$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression

$rows = @(
    @('wr_eyes_drill.html', '用网球进行自抛自接、教练抛接和轮流抓接，训练 U6 队员盯球、张指抓握与接球缓冲。', 'WR/外接手', 'offense_drill/wr/wr_eyes_drill.html')
    @('speedcut_drill_02.html', 'WR 冲刺接近标志锥后以外侧脚一步砸地、快速转髋切入新路线，并在切出后寻找 QB 接球。', 'WR/外接手', 'offense_drill/wr/speedcut_drill_02.html')
    @('speedcut_drill_01.html', '队员冲刺至标志锥后以外侧脚蹬地并转髋，一步切入新路线，重点是不加多余碎步、保持速度。', 'WR/外接手', 'offense_drill/wr/speedcut_drill_01.html')
    @('slant_cut.html', '队员接近标志锥时前倾降重心、侧向蹬地并切入 Slant 斜线，训练变向爆发及切出后接球。', 'WR/外接手', 'offense_drill/wr/slant_cut.html')
    @('side_catch.html', 'WR 横向跑动时转动上身迎向 QB 来球，以合适手型侧前方接球，随后收球并继续前冲。', 'WR/外接手', 'offense_drill/wr/side_catch.html')
    @('sidelinefootwork_drill_01.html', 'WR 在静态及跑动接球中控制界内首脚或脚尖点地，练习边线附近接球、平衡和护球。', 'WR/外接手', 'offense_drill/wr/sidelinefootwork_drill_01.html')
    @('ready_drill_01.html', 'WR 练习两点式预备站姿，并根据开球口令以后脚蹬地、避免后撤步地快速启动冲刺。', 'WR/外接手', 'offense_drill/wr/ready_drill_01.html')
    @('deadeyes.html', '队员根据教练随机抛来的不同方向和高度的球启动接球，练习持续盯球、正确手型与接后护球。', '接球/通用', 'offense_drill/wr/deadeyes.html')
    @('catching_disruption_drill_02.html', '页面正文为空，无法从页面内容确定训练项目。', '未注明', 'offense_drill/wr/catching_disruption_drill_02.html')
    @('catching_disruption_drill_01.html', 'WR 在两名防守队员从两侧干扰时卡位并盯球完成接球，同时防守队员练习拍击破坏传球。', 'WR/外接手', 'offense_drill/wr/catching_disruption_drill_01.html')
    @('3steps_cut.html', 'WR 冲刺后用三步降低重心并刹车，贴近标志锥绕行，再次加速并在出口处接球。', 'WR/外接手', 'offense_drill/wr/3steps_cut.html')
    @('3steps_circle_02.html', 'WR 接近标志锥时执行三步急停、低重心贴锥环绕，随后重新加速，重点练习刹车和绕点控制。', 'WR/外接手', 'offense_drill/wr/3steps_circle_02.html')
    @('3steps_circle.html', 'WR 连续通过 Z 字路线上的四个锥点，每次以“前两步调整、第三步蹬地”的节奏完成 Slant 变向。', 'WR/外接手', 'offense_drill/wr/3steps_circle.html')
    @('handoff_drill_01.html', 'QB 将球放入跑卫建立的口袋，跑卫感知球入袋后合拢护球并向前加速。', '交接/跑卫与四分卫', 'offense_drill/handoff/handoff_drill_01.html')
    @('handoff_drill_02.html', '跑卫轮流从 QB 左右两侧接球，练习根据交接方向调整上下手臂位置并将球抱紧冲刺。', '交接/跑卫与四分卫', 'offense_drill/handoff/handoff_drill_02.html')
    @('handoff_drill_03.html', '跑卫听取身前或身后交递指令，调整身体和口袋方向接球后抱紧冲刺。', '交接/跑卫与四分卫', 'offense_drill/handoff/handoff_drill_03.html')
    @('handoff_drill_04.html', 'QB 与 RB 练习真假交递时一致的跑位、口袋和身体遮挡动作，由 RB 假装持球突击以迷惑防守。', '交接/跑卫与四分卫', 'offense_drill/handoff/handoff_drill_04.html')
    @('handoff_drill_05.html', 'QB、RB 与 WR 配合演练真假交递、Reverse 反跑及后续传球，练习战术衔接和球权保护。', '战术协同/QB、RB与WR', 'offense_drill/handoff/handoff_drill_05.html')
    @('handoff_drill_06.html', 'QB 与多名 RB 练习 Toss 传球和连续 Reverse 反向交球，重点是路线配合、喊话和接球护球。', '交接/跑卫与四分卫', 'offense_drill/handoff/handoff_drill_06.html')
    @('rb_cut_drill_01.html', 'RB 持球沿 Z 字路线主动逼近模拟防守者，再以外侧脚一步蹬地、低重心转髋切过防守点。', 'RB/跑卫', 'offense_drill/rb/rb_cut_drill_01.html')
    @('quarterspin_drill_03.html', 'RB 在一对一拔旗中先做头肩假动作，再于防守者出手时以四分之一转髋切入摆脱。', 'RB/跑卫', 'offense_drill/rb/quarterspin_drill_03.html')
    @('quarterspin_drill_02.html', 'RB 持球冲至标志锥后以异侧脚蹬地转髋，立即切向目标锥，并可根据教练信号选择方向。', 'RB/跑卫', 'offense_drill/rb/quarterspin_drill_02.html')
    @('quarterspin_drill_01.html', 'RB 原地微跳或单脚蹬地后快速转髋约四分之一圈，练习核心带动转向并保持持球稳定。', 'RB/跑卫', 'offense_drill/rb/quarterspin_drill_01.html')
    @('handoff_tf.html', 'QB 向多名 RB 连续 Toss 并衔接 Reverse 反向交球，练习多名跑卫之间的战术路线和传接配合。', '交接/跑卫与四分卫', 'offense_drill/rb/handoff_tf.html')
    @('rb_toss_reverse_drill.html', 'QB 将球 Toss 给 RB1，RB1 再在交接点将球 Reverse 给 RB2，练习多名跑卫的反向交球配合。', '交接/跑卫与四分卫', 'offense_drill/rb/rb_toss_reverse_drill.html')
    @('rb_mislead_cut.html', 'RB 以头部和视线向假方向误导防守者，再以一步蹬地和转髋切入真实目标路线。', 'RB/跑卫', 'offense_drill/rb/rb_mislead_cut.html')
    @('rb_jump_cut.html', '队员低重心接近切步点后单脚蹬地、短暂转髋并向侧方切出，练习急停跳切的发力和重心转换。', 'RB/跑卫', 'offense_drill/rb/rb_jump_cut.html')
    @('rb_stance_drill_01.html', 'RB 从两点式预备站姿听口令向前或斜前方爆发启动，练习第一步发力和抬头观察。', 'RB/跑卫', 'offense_drill/rb/rb_stance_drill_01.html')
    @('rb_quick_feet.html', '队员通过绳梯或小跨栏练习高频小步、横向步频和前脚掌触地，并在通过后加速冲刺。', 'RB/跑卫', 'offense_drill/rb/rb_quick_feet.html')
    @('qb_finger_drill_01.html', 'U6 队员仅用指腹在双手之间快速左右拨球，练习触球球感和抬头控球。', '通用/未注明', 'offense_drill/qb/qb_finger_drill_01.html')
    @('qb_3stepsdrop_drill.html', 'QB 完成三步后撤并以第三步扎地定向，再通过蹬地转髋将球投向目标。', 'QB/四分卫', 'offense_drill/qb/qb_3stepsdrop_drill.html')
    @('qb_move_pass.html', 'QB 练习向前推进和左右 Rollout 移动时稳定持球、转向目标并在行进中传球。', 'QB/四分卫', 'offense_drill/qb/qb_move_pass.html')
    @('qb_Hip-Shoulder.html', 'QB 在站定状态下先转髋、保持肩部滞后，再利用核心回弹和上肢鞭打完成投掷。', 'QB/四分卫', 'offense_drill/qb/qb_Hip-Shoulder.html')
    @('catching_handsharp_drill_03.html', 'U6 队员以指腹维持钻石手型抓住橄榄球，并在教练轻拍或推挤球时保持持球稳定。', '接球/通用', 'offense_drill/catching_handsharp/catching_handsharp_drill_03.html')
    @('catching_handsharp_drill_02.html', '队员沿横向或斜向路线接高球或低平球，在视觉干扰下调整手型并迅速锁球。', '接球/通用', 'offense_drill/catching_handsharp/catching_handsharp_drill_02.html')
    @('catching_handsharp_drill_01.html', '队员根据高低来球快速选择钻石手或篮筐手型接球，并将球收至腋下。', '接球/通用', 'offense_drill/catching_handsharp/catching_handsharp_drill_01.html')
    @('ball_spot_drill_01.html', '队员追踪教练高抛球的飞行和落点，在移动中判断位置并用正确手型接球。', '接球/通用', 'offense_drill/ball_spot/ball_spot_drill_01.html')
    @('crossstep_drill_01.html', '练习 DB 以交叉步/Weave 后退并保持低重心和对进攻球员的视线，跟随其纵向或斜向路线移动。', 'DB/防守后卫', 'defense_drill/db/crossstep_drill_01.html')
    @('bp_to_shuffle.html', 'DB 连续练习后退、Plant/T-Step 前冲及按手势左右滑步，以训练多方向步态转换和封堵。', 'DB/防守后卫', 'defense_drill/db/bp_to_shuffle.html')
    @('backpedal_tstep.html', 'DB 后退至信号点后用 T-Step 刹车转向，低重心前压冲刺并完成贴防或拔旗。', 'DB/防守后卫', 'defense_drill/db/backpedal_tstep.html')
    @('backpedal_drill_03.html', '两名队员同步后退并观察 QB 转向，随后分别执行 WR 路线接球或 DB 转髋贴防、外侧手破坏传球。', 'DB/防守后卫（含 WR 对抗）', 'defense_drill/db/backpedal_drill_03.html')
    @('backpedal_drill_02.html', '练习以低重心和前脚掌发力完成直线后退，并根据口令将后退衔接为交叉步跟防或向前冲刺。', 'DB/防守后卫', 'defense_drill/db/backpedal_drill_02.html')
    @('backpedal_drill.html', '初学者练习屈膝低姿、前脚掌连续推地和小步幅后退，以建立稳定的直线 Backpedal 动作。', 'DB/防守后卫', 'defense_drill/db/backpedal_drill.html')
    @('playaction.html', '防守队员观察球的真实去向以识别真假交递，再封堵持球路线并尝试拔旗。', '防守队员/通用', 'defense_drill/db/playaction.html')
    @('d_passing.html', 'DB 练习以外侧手破坏空中传球，并在接球后以内侧手瞄准腰旗完成拔旗。', 'DB/防守后卫', 'defense_drill/db/d_passing.html')
    @('crossstep_drill_02.html', 'DB 从直线后退根据视觉信号转为前交叉步，转髋跟随 WR 的侧向或斜向切入。', 'DB/防守后卫', 'defense_drill/db/crossstep_drill_02.html')
    @('shuffle_game.html', 'U6 持球人连续突破三道防线，防守队员则限定在各自码线上横向滑步封堵。', '防守队员/通用（进攻对抗）', 'defense_drill/db/shuffle_game.html')
    @('shuffle.html', 'U6 队员练习低重心、双脚不交叉的横向滑步、急停折返和跟随视觉信号移动。', '防守队员/通用', 'defense_drill/db/shuffle.html')
    @('zone_containment_01.html', 'U7–U8 防守队员练习区域站位、在责任区内滑步盯防，并通过呼喊完成区域交接。', '防守队员/通用（区域防守）', 'defense_drill/db/zone_containment_01.html')
    @('flagpulling_drill_02.html', '防守队员练习冲刺接近持球人后主动降速、降低重心并调整脚步，再完成拔旗。', '防守擒旗/通用', 'defense_drill/flagpulling/flagpulling_drill_02.html')
    @('flagpulling_drill_01.html', '两人近距离练习低重心瞄准腰带根部、准确抓拔腰旗并避免拉扯衣物。', '防守擒旗/通用', 'defense_drill/flagpulling/flagpulling_drill_01.html')
)

if ($rows.Count -ne 51) { throw "Expected 51 drill pages, got $($rows.Count)" }

$outputPath = Join-Path $PSScriptRoot '训练内容统计.xlsx'
$tempPath = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
[System.IO.Directory]::CreateDirectory($tempPath) | Out-Null

function Write-Utf8File([string]$Path, [string]$Content) {
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Escape-Xml([string]$Value) {
    return [System.Security.SecurityElement]::Escape($Value)
}

function Column-Name([int]$Number) {
    $name = ''
    while ($Number -gt 0) {
        $Number--
        $name = [char](65 + ($Number % 26)) + $name
        $Number = [math]::Floor($Number / 26)
    }
    return $name
}

function New-WorksheetXml($Data, [string[]]$Headers, [int[]]$Widths, [bool]$Filter, [int]$FreezeRows) {
    $lastCol = Column-Name $Headers.Count
    $lastRow = $Data.Count + 1
    $xmlRows = [System.Collections.Generic.List[string]]::new()
    $headCells = for ($c = 0; $c -lt $Headers.Count; $c++) {
        '<c r="' + (Column-Name ($c + 1)) + '1" s="1" t="inlineStr"><is><t>' + (Escape-Xml $Headers[$c]) + '</t></is></c>'
    }
    $xmlRows.Add('<row r="1">' + ($headCells -join '') + '</row>')
    for ($r = 0; $r -lt $Data.Count; $r++) {
        $cells = for ($c = 0; $c -lt $Headers.Count; $c++) {
            $value = Escape-Xml ([string]$Data[$r][$c])
            '<c r="' + (Column-Name ($c + 1)) + ($r + 2) + '" t="inlineStr"><is><t xml:space="preserve">' + $value + '</t></is></c>'
        }
        $xmlRows.Add('<row r="' + ($r + 2) + '">' + ($cells -join '') + '</row>')
    }
    $cols = for ($i = 0; $i -lt $Widths.Count; $i++) { '<col min="' + ($i + 1) + '" max="' + ($i + 1) + '" width="' + $Widths[$i] + '" customWidth="1"/>' }
    $pane = if ($FreezeRows -gt 0) { '<sheetViews><sheetView workbookViewId="0"><pane ySplit="' + $FreezeRows + '" topLeftCell="A' + ($FreezeRows + 1) + '" activePane="bottomLeft" state="frozen"/></sheetView></sheetViews>' } else { '' }
    $filter = if ($Filter) { '<autoFilter ref="A1:' + $lastCol + $lastRow + '"/>' } else { '' }
    return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' + $pane + '<cols>' + ($cols -join '') + '</cols><sheetData>' + ($xmlRows -join '') + '</sheetData>' + $filter + '</worksheet>'
}

$detail = New-WorksheetXml $rows @('文件名', '训练核心内容', '位置大类', '相对路径') @(34, 78, 32, 68) $true 1
$summaryRows = @(
    @('统计项目', '数量')
    @('总训练页数', $rows.Count)
    @('进攻训练页', @($rows | Where-Object { $_[3].StartsWith('offense_drill/') }).Count)
    @('防守训练页', @($rows | Where-Object { $_[3].StartsWith('defense_drill/') }).Count)
)
$categoryCounts = $rows | Group-Object { $_[2] } | Sort-Object Name
foreach ($category in $categoryCounts) { $summaryRows += ,@($category.Name, $category.Count) }
$summary = New-WorksheetXml $summaryRows @('统计项目', '数量') @(42, 16) $false 1

$files = @{
    '[Content_Types].xml' = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/></Types>'
    '_rels/.rels' = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>'
    'xl/workbook.xml' = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="训练明细" sheetId="1" r:id="rId1"/><sheet name="分类统计" sheetId="2" r:id="rId2"/></sheets></workbook>'
    'xl/_rels/workbook.xml.rels' = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>'
    'xl/styles.xml' = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><fonts count="2"><font><sz val="11"/><name val="Calibri"/></font><font><b/><color rgb="FFFFFFFF"/><sz val="11"/><name val="Calibri"/></font></fonts><fills count="3"><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="gray125"/></fill><fill><patternFill patternType="solid"><fgColor rgb="FF245A4A"/><bgColor indexed="64"/></patternFill></fill></fills><borders count="1"><border><left/><right/><top/><bottom/><diagonal/></border></borders><cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs><cellXfs count="2"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0" applyAlignment="1"><alignment vertical="top" wrapText="1"/></xf><xf numFmtId="0" fontId="1" fillId="2" borderId="0" xfId="0" applyAlignment="1"><alignment vertical="center" wrapText="1"/></xf></cellXfs></styleSheet>'
}
$files['xl/worksheets/sheet1.xml'] = $detail
$files['xl/worksheets/sheet2.xml'] = $summary
foreach ($entry in $files.GetEnumerator()) {
    $path = Join-Path $tempPath $entry.Key
    [System.IO.Directory]::CreateDirectory([System.IO.Path]::GetDirectoryName($path)) | Out-Null
    Write-Utf8File $path $entry.Value
}
if (Test-Path $outputPath) { Remove-Item $outputPath }
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempPath, $outputPath)
Remove-Item $tempPath -Recurse -Force
Write-Output "Created $outputPath with $($rows.Count) detail rows."