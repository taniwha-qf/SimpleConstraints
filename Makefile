KSPDIR		:= ${HOME}/ksp/KSP_linux
MANAGED		:= ${KSPDIR}/KSP_Data/Managed
GAMEDATA	:= ${KSPDIR}/GameData
SCGAMEDATA  := ${GAMEDATA}/SimpleConstraints
PLUGINDIR	:= ${SCGAMEDATA}/Plugins

TARGETS		:= SimpleConstraints.dll

SC_FILES := \
	CopyLocation.cs \
	$e

DOC_FILES := \
	../License.txt \
	$e

#	SimpleConstraints.png
#	README.md

RESGEN2		:= resgen2
GMCS		:= mcs
GMCSFLAGS	:= -optimize -warnaserror
GIT			:= git
TAR			:= tar
ZIP			:= zip

all: version ${TARGETS} #SimpleConstraints.png

.PHONY: version
version:
	@#./git-version.sh

info:
	@echo "SimpleConstraints Build Information"
	@echo "    resgen2:    ${RESGEN2}"
	@echo "    gmcs:       ${GMCS}"
	@echo "    gmcs flags: ${GMCSFLAGS}"
	@echo "    git:        ${GIT}"
	@echo "    tar:        ${TAR}"
	@echo "    zip:        ${ZIP}"
	@echo "    KSP Data:   ${KSPDIR}"

SimpleConstraints.dll: ${SC_FILES}
	${GMCS} ${GMCSFLAGS} -t:library -lib:${MANAGED} \
		-r:Assembly-CSharp,Assembly-CSharp-firstpass \
		-r:UnityEngine \
		-r:UnityEngine.UI \
		-r:UnityEngine.CoreModule \
		-out:$@ $^

#SimpleConstraints.png: SimpleConstraints.svg
#	inkscape --export-png $@ $^

clean:
	rm -f ${TARGETS} AssemblyInfo.cs #SimpleConstraints.png

install: all
	mkdir -p ${PLUGINDIR}
	cp ${TARGETS} ${PLUGINDIR}
	#cp ${DOC_FILES} ${SCGAMEDATA}

.PHONY: all clean install
