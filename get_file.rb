require 'digest/md5' 
require 'open-uri'
require 'json'

def hexdec(_h)
	case _h.to_s
	when "a"
		return 10
	when "b"
		return 11
	when "c"
		return 12
	when "d"
		return 13
	when "e"
		return 14
	when "f"
		return 15
	else 
		return _h.to_i
	end
end

def substr(_str,_start)
	_s=[0]
	_i=0
	_ii=0
	for _o in 0..((_str.size.to_i)-1)
		if _i > _start or _i == _start
			_s[_ii]=_str[_i]
			_ii+=1
		end
		_i+=1
	end
	return _s.join("").to_s
end

def makeUrlCore(_filename,_version)
	_domain="cache.projecttokyodolls.jp"
	_backet="dolls.prd.cdn"
	_hash=Digest::MD5.hexdigest((_backet+"/"+(_version.to_s))).to_s
	_hash2=Digest::MD5.hexdigest(substr(_hash,_hash[0].to_i))
	_org_filename=(_filename.to_s)+".abap"
	_platform="dro"
	return "http://"+_domain+"/"+_hash2+"/"+_platform+"/"+_org_filename
end

def dl_fileCore(_url)
	puts "open url:#{_url}"
	_i=open(_url,"rb")
	_p=_url.split("/")
	_p=_p[_p.size-1]
	_ii=File.open(_p,"wb")
	_i.each do |line|
		_ii.write(line)
	end
	_ii.close
	_i.close
	puts "save #{_p}"
end
json=File.read("MD_AssetbundleDLPackVer-dec.json")
obj=JSON.parse(json)
obj.each do |info|
	tmp_valv=info.join(",").to_s.split(",")
	ver=tmp_valv[3].to_s
	name=tmp_valv[0].to_s
	#dl_fileCore(makeUrlCore("21_UI_Illust_01_Costume_001_dol","60200"))
	dl_fileCore(makeUrlCore(name,ver))
end
#dl_fileCore(makeUrlCore("21_UI_Illust_01_Costume_001_dol","60200"))
