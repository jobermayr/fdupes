default:
	@echo No target specified. Valid targets:
	@echo " tarball"
	@echo " tarball-dev"
	@echo " clean"
tarball:
	cd dist ; make clean
	$(ARCHIVE) dist fdupes-$(VERSION)
	$(GNU_TAR) -c -z -v -f fdupes-$(VERSION).tar.gz fdupes-$(VERSION)
	$(RMRF) fdupes-$(VERSION)

tarball-dev: clean
	$(GNU_TAR) --directory=.. -c -z -v -f \
	../fdupes-$(DATE).tar.gz fdupes-dev

clean:
	cd dist ; make clean
	$(RM) *~
	$(RM) *.tar.gz
	$(RM) website/*~

include dist/Makefile.inc/VERSION

DATE = `date +%Y%m%d.%H%M`

GNU_TAR = tar		# tar : GNU Tar 
#GNU_TAR = gtar

ARCHIVE = cp -a

RM 	= rm -f

RMRF    = rm -rf

