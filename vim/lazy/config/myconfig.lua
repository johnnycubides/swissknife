local function file_exists(file)
	local f = io.open(file, "r")
	if f then
		f:close()
		return true
	else
		return false
	end
end

if file_exists("./pro.vim") then
	print("existe ./pro.vim")
	vim.cmd("source ./pro.vim")
elseif file_exists("./.pro.vim") then
	print("existe ./.pro.vim")
	vim.cmd("source ./.pro.vim")
end
