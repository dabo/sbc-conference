
docs/syllabus.html:	program-2025.dat script/header.php script/footer.php script/GenProgram.pl
	perl script/GenProgram.pl program-2026.dat

clean:
	rm ./docs/program-2026.html

