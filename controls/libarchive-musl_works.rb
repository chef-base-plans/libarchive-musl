title 'Tests to confirm libarchive binaries work as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libarchive-musl")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libarchive-musl' do
  impact 1.0
  title 'Ensure libarchive-musl binaries are working as expected'
  desc '
  We first check that the three binaries we expect are present and then run version checks on both to verify that they are excecutable.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  bsdcat_exists = command("ls #{File.join(target_dir, "bsdcat")}")
  describe bsdcat_exists do
    its('stdout') { should match /bsdcat/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcat_works = command("#{File.join(target_dir, "bsdcat")} --version")
  describe bsdcat_works do
    its('stdout') { should match /bsdcat [0-9]+.[0-9]+.[0-9]+/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcpio_exists = command("ls #{File.join(target_dir, "bsdcpio")}")
  describe bsdcpio_exists do
    its('stdout') { should match /bsdcpio/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcpio_works = command("#{File.join(target_dir, "bsdcpio")} --version")
  describe bsdcpio_works do
    its('stdout') { should match /bsdcpio [0-9]+.[0-9]+.[0-9]+/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdtar_exists = command("ls #{File.join(target_dir, "bsdtar")}")
  describe bsdtar_exists do
    its('stdout') { should match /bsdtar/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdtar_works = command("#{File.join(target_dir, "bsdtar")} --version")
  describe bsdtar_works do
    its('stdout') { should match /bsdtar [0-9]+.[0-9]+.[0-9]+/ }
    its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
