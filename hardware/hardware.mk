FIR_HW_DIR:=$(FIR_DIR)/hardware

#sources
FIR_SRC_DIR:=$(FIR_HW_DIR)/src
VSRC+=$(wildcard $(FIR_SRC_DIR)/*.v)
