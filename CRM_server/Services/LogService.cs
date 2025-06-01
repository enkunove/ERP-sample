using System;
using System.IO;
using System.Threading;
using Server.Models;
using SerializerLib;
using System.Text.Json;

namespace Server.Services
{
    public class LogService
    {
        private readonly string _logDirectory = Path.Combine(AppContext.BaseDirectory, "logs");
        private readonly string _jsonLogFile;
        private readonly string _tomlLogFile;

        private static readonly object _jsonLock = new();
        private static readonly object _tomlLock = new();

        public LogService()
        {
            Directory.CreateDirectory(_logDirectory);
            _jsonLogFile = Path.Combine(_logDirectory, "log.json");
            _tomlLogFile = Path.Combine(_logDirectory, "log.toml");
        }

        public void LogAsJson(Log log)
        {
            string json = Serializer.ToJson(log);
            lock (_jsonLock)
            {
                AppendToFile(_jsonLogFile, "[JSON LOG]\n" + json + "\n");
            }
        }

        public void LogAsToml(Log log)
        {
            string toml = Serializer.ToToml(log);
            lock (_tomlLock)
            {
                AppendToFile(_tomlLogFile, "[TOML LOG]\n" + toml + "\n");
            }
        }

        public void LogAllFormats(string @event, object data)
        {
            var log = new Log
            {
                Event = @event,
                Data = data,
                Type = data.GetType().Name
            };

            LogAsJson(log);
            LogAsToml(log);
        }

        private void AppendToFile(string path, string content)
        {
            using var writer = new StreamWriter(path, append: true);
            writer.WriteLine(content);
        }


        public List<Log> GetJsonLogs()
            {
                var logs = new List<Log>();
                if (!File.Exists(_jsonLogFile))
                    return logs;

                lock (_jsonLock)
                {
                    string[] lines = File.ReadAllLines(_jsonLogFile);

                    for (int i = 0; i < lines.Length; i++)
                    {
                        if (lines[i].Trim() == "[JSON LOG]" && i + 1 < lines.Length)
                        {
                            var jsonLine = lines[++i];
                            Console.WriteLine("Parsing JSON: " + jsonLine);

                            try
                            {
                                var log = JsonSerializer.Deserialize<Log>(jsonLine, new JsonSerializerOptions
                                {
                                    PropertyNameCaseInsensitive = true
                                });

                                if (log != null)
                                {
                                    logs.Add(log);
                                    Console.WriteLine($"Parsed log event: {log.Event}");
                                }
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine("Ошибка при парсинге: " + ex.Message);
                            }
                        }
                    }
                }
                return logs;
            }

        public List<Log> GetTomlLogs()
            {
                var logs = new List<Log>();
                if (!File.Exists(_tomlLogFile))
                    return logs;

                lock (_tomlLock)
                {
                    string[] lines = File.ReadAllLines(_tomlLogFile);
                    var tomlEntry = "";
                    bool readingLog = false;

                    foreach (var line in lines)
                    {
                        if (line.Trim() == "[TOML LOG]")
                        {
                            if (readingLog && !string.IsNullOrWhiteSpace(tomlEntry))
                            {
                                try
                                {
                                    var log = Serializer.FromToml<Log>(tomlEntry);
                                    if (log != null)
                                        logs.Add(log);
                                }
                                catch { }
                            }
                            tomlEntry = "";
                            readingLog = true;
                        }
                        else if (readingLog)
                        {
                            tomlEntry += line + "\n";
                        }
                    }

                    if (readingLog && !string.IsNullOrWhiteSpace(tomlEntry))
                    {
                        try
                        {
                            var log = Serializer.FromToml<Log>(tomlEntry);
                            if (log != null)
                                logs.Add(log);
                        }
                        catch { }
                    }
                }
                return logs;
            }

    }
}
