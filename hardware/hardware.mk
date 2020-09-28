FIR_HW_DIR:=$(FIR_DIR)/hardware

#include
FIR_INC_DIR:=$(FIR_HW_DIR)/include
INCLUDE+=$(incdir) $(FIR_INC_DIR)

#headers
VHDR+=$(wildcard $(FIR_INC_DIR)/*.vh)

#sources
FIR_SRC_DIR:=$(FIR_HW_DIR)/src
VSRC+=$(wildcard $(FIR_SRC_DIR)/*.v)
