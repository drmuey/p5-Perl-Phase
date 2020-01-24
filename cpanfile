# kind of duplicate of Makefile.PL
#	but convenient for Continuous Integration

on 'test' => sub {
	requires "Devel::Peek"         => 0;
	requires "ExtUtils::MakeMaker" => 0;
	requires "File::Spec"          => 0;
	requires "Test::Spec"          => 0;
};