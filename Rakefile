task :'spec:example1' do
  sh 'rake', '-C', 'example1'
end

task :'spec:example2' do
  sh 'rake', '-C', 'example2'
end

task :spec => [:'spec:example1', :'spec:example2']

task :default => :spec

