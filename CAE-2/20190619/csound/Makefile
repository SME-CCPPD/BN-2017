TARGET = out.wav
CSOUND = csound -3dW
SCORE = output.sco
PYTHON = python3
ORC = Driver.orc
SOURCE = ../Rivelatore/drive.py

$(TARGET): $(SCORE)
	$(CSOUND) -o ./$@ $(ORC) $(SCORE)

$(SCORE):
	$(PYTHON) $(SOURCE) > $@

clean:
	$(RM) $(TARGET) $(SCORE)
