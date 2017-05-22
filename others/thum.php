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
$dir=$_SERVER['argv'][1];
$width=$_SERVER['argv'][2]??200;
$files=dirToArray($dir);

foreach ($files as $file)
{
    $pathinfo=pathinfo($file);
    if(substr($file,-6)==('_s.'.$pathinfo['extension']))continue;
    $thum=$pathinfo['dirname'].DIRECTORY_SEPARATOR.$pathinfo['filename'].'_s.'.$pathinfo['extension'];
    if(is_file($thum))continue;
    $type='';
    switch ($pathinfo['extension'])
    {
        case 'jpg':
            $source=imagecreatefromjpeg($file);
            $func='imagejpeg';
            $type='jpg';
            break;
        case 'png':
            $source=imagecreatefrompng($file);
            $func='imagepng';
            $type='png';
            break;
        default:
            continue;
    }
    $w=imagesx($source);
    $h=imagesy($source);
    $height=intval($width*$h/$w);
    $target=imagecreatetruecolor($width,$height);
    if($type=='png')
    {
        $alpha = imagecolorallocatealpha($target, 0, 0, 0, 127);
        imagefill($target, 0, 0, $alpha);
    }
    imagecopyresampled($target, $source, 0, 0, 0, 0, $width, $height, $w, $h);
    if($type=='png')
    {
        imagesavealpha($target, true);
    }
    $func($target,$thum);

}