<?php



function dirToArray($dir) {

    $result = array();

    $cdir = scandir($dir);
    foreach ($cdir as $key => $value)
    {
        if (!in_array($value,array(".","..",'.git','.idea')))
        {
            if (is_dir($dir . DIRECTORY_SEPARATOR . $value))
            {
                $result = array_merge($result,dirToArray($dir . DIRECTORY_SEPARATOR . $value));
            }
            else
            {
                $result[] = $dir.'/'.$value;
            }
        }
    }

    return $result;
}

$files=dirToArray('.');

$md5s=[];
foreach ($files as $val)
{
    if(in_array($val,['./index.html','./update.php','./md5.js']))
    {
        continue;
    }

    $md5=md5(file_get_contents($val));

    $val=str_replace('\\','/',substr($val,1));
    $md5s[md5($val)]=$md5;
}

$str="var FILE_MD5=".json_encode($md5s);
file_put_contents('md5.js',$str);


$rand=strtotime(date('Y-m-d H:i:0'));
$file=$_SERVER['argv'][1]??'index.html';
$str=file_get_contents($file);
preg_match_all('/<[link|script](.*?)[href|src]="(.*?)"/is',$str,$files);
$search=[];
$replace=[];
foreach ($files[2] as $f)
{
    $path=(parse_url($f)['path']);
    $file=__DIR__.$path;
    if (is_file($file))
    {
        $search[]=$f;
        $replace[]=$path.'?_='.md5(file_get_contents($file));
    }
}




$str=str_replace($search,$replace,$str);
file_put_contents($file,$str);
echo $str;


