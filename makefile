CC = gcc
CXX = g++
DEBUG = 
CXXFLAGS = $(shell fltk-config --use-gl --use-images --cxxflags ) $(shell pkg-config glfw3 --cflags)  -I. -I/usr/local/Cellar/glad/include -I/usr/local/Cellar/learnopengl
LDFLAGS = $(shell fltk-config --use-gl --use-glut --use-images --ldflags ) $(shell pkg-config glfw3 --libs) $(shell pkg-config glew --libs) -lcommon -lGLAD -lstb_image -lassimp

TARGET = app
SRCS = main.cpp
OBJS = $(SRCS:.cpp=.o)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -c $< -o $@

all: $(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LDFLAGS)

.PHONY: clean
clean:
	rm -f *.o 2> /dev/null
	rm -f $(TARGET) 2> /dev/null
