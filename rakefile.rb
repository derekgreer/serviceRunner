require 'rubygems'
require 'albacore'

MSBUILD_PATH = "C:/Windows/Microsoft.NET/Framework/v4.0.30319/"
BUILD_PATH = File.expand_path('build')
LIB_PATH = File.expand_path('lib')
SOLUTION = "src/ServiceRunner.sln"
COMPILE_TARGET = "Release"
nuget = 'nuget'
#load "VERSION.txt"

task :default => ["build:all"]

namespace :build do

	task :all => [:clean, :compile]

	assemblyinfo :versioning do |asm|
		BUILD_VERSION=File.read('VERSION.txt').strip;
  		asm.output_file = "src/CommonAssemblyInfo.cs"
  		asm.version = "#{BUILD_VERSION}"
	end

	task :clean do
		rm_rf "#{BUILD_PATH}"
		rm_rf "#{LIB_PATH}"
	end

	task :compile => [:versioning] do

		mkdir "#{BUILD_PATH}"
		sh "#{MSBUILD_PATH}msbuild.exe /p:Configuration=#{COMPILE_TARGET} #{SOLUTION}"
		copyOutputFiles "src/ServiceRunner/bin/#{COMPILE_TARGET}", "*.exe", "#{BUILD_PATH}"
	end

	def copyOutputFiles(fromDir, filePattern, outDir)
		Dir.glob(File.join(fromDir, filePattern)){|file| 		
			copy(file, outDir) if File.file?(file)
  		} 
	end
end
