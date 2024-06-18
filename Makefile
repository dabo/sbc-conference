
docs/syllabus.html:	program.dat script/header.php script/footer.php script/GenProgram.pl
	perl script/GenProgram.pl program.dat

clean:
	rm ./docs/program.html

