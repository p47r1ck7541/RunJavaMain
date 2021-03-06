MAIN_CLASS=HelloWorld

%.class: %.java
	javac -source 1.7 -target 1.7 -cp "$(ANDROID_HOME)"/platforms/android-27/android.jar $<

classes.dex: $(MAIN_CLASS).class
	$(ANDROID_HOME)/build-tools/27.0.3/dx --dex --output $@ $<

all: classes.dex

run: all
	adb push classes.dex /data/local/tmp
	adb shell CLASSPATH=/data/local/tmp/classes.dex app_process / $(MAIN_CLASS)
