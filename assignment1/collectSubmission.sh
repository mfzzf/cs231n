#!/bin/bash
#注意：请勿编辑此文件——可能导致提交不完整
set -euo pipefail

CODE=(
	"cs231n/classifiers/k_nearest_neighbor.py"
	"cs231n/classifiers/linear_classifier.py"
	"cs231n/classifiers/softmax.py"
	"cs231n/classifiers/fc_net.py"
	"cs231n/optim.py"
	"cs231n/solver.py"
	"cs231n/layers.py"
)

# 这些 notebook 应该按问题顺序排列
# 以便生成的 PDF
# 按问题顺序排列
NOTEBOOKS=(
	"knn.ipynb"
	"softmax.ipynb"
	"two_layer_net.ipynb"
	"features.ipynb"
	"FullyConnectedNets.ipynb"
)

FILES=( "${CODE[@]}" "${NOTEBOOKS[@]}" )

LOCAL_DIR=`pwd`
ASSIGNMENT_NO=1
ZIP_FILENAME="a1_code_submission.zip"
PDF_FILENAME="a1_inline_submission.pdf"

C_R="\e[31m"
C_G="\e[32m"
C_BLD="\e[1m"
C_E="\e[0m"

for FILE in "${FILES[@]}"
do
	if [ ! -f ${FILE} ]; then
		echo -e "${C_R}必需文件 ${FILE} 未找到，正在退出。${C_E}"
		exit 0
	fi
done

echo -e "### 正在压缩文件 ###"
rm -f ${ZIP_FILENAME}
zip -q "${ZIP_FILENAME}" -r ${NOTEBOOKS[@]} $(find . -name "*.py") "cs231n/saved" -x "makepdf.py"

echo -e "### 正在创建 PDF ###"
python makepdf.py --notebooks "${NOTEBOOKS[@]}" --pdf_filename "${PDF_FILENAME}"

echo -e "### 完成！请将 ${ZIP_FILENAME} 和 ${PDF_FILENAME} 提交到 Gradescope。 ###"
