php
<?php
/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.1.5 (VISUALIZER) */
$file = "/dev/shm/fire-gem-0x0f17e6e3";
$handle = @fopen($file, "rb");
fseek($handle, 64);
$data = fread($handle, 32);
$hex = bin2hex($data);
fclose($handle);
?>
<html>
<body style="background:#000; color:#0f0; font-family:monospace;">
  <h1>[BGIN] SENTINEL-OS VISUAL MONITOR</h1>
  <canvas id="pulseWave" width="800" height="200" style="border:1px solid #0f0;"></canvas>
  <pre>RAW: <?php echo trim($data); ?></pre>
  <pre>HEX: <?php echo strtoupper(chunk_split($hex, 2, ' ')); ?></pre>

  <script>
    const canvas = document.getElementById('pulseWave');
    const ctx = canvas.getContext('2d');
    const hexData = "<?php echo $hex; ?>";
    
    function draw() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.beginPath();
      ctx.strokeStyle = '#0f0';
      ctx.lineWidth = 2;
      
      for(let i=0; i < hexData.length; i+=2) {
        let val = parseInt(hexData.substr(i, 2), 16);
        let x = (i/hexData.length) * canvas.width;
        let y = canvas.height - (val / 255) * canvas.height;
        i === 0 ? ctx.moveTo(x, y) : ctx.lineTo(x, y);
      }
      ctx.stroke();
    }
    draw();
  </script>
</body>
</html>
