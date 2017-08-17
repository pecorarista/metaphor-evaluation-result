#!/bin/bash

cat ${1} \
    | sed -e 's/X//g' \
    | sed -e 's/に溺れる/X ni oboreru (Y almost drowns in X)/' \
    | sed -e 's/が沸騰する/X ga huttou-suru (X boils)/' \
    | sed -e 's/に沈む/X ni sizumu (Y sinks into X)/' \
    | sed -e 's/が渦巻く/X ga uzumaku (X whirls)/' \
    | sed -e 's/がこぼれる/X ga koboreru (X spills out)/' \
    | sed -e 's/が淀む/X ga yodomu (X gets stagnant)/' \
    | sed -e 's/が滴る/X ga sitataru (X drips)/' \
    | sed -e 's/を飲む/X wo nomu (Y drinks X)/' \
    | sed -e 's/が濁る/X ga nigoru (X gets cloudy)/' \
    | sed -e 's/を啜る/X wo susuru (Y sips X)/' \
    | sed -e 's/に漬かる/X ni tukaru (Y gets submerged in X)/' \
    | sed -e 's/が湧く/X ga waku (X gushes out)/' \
    | sed -e 's/を浴びせる/X wo abiseru (Y showers X)/' \
    | sed -e 's/が滲む/X ga nizimu (X oozes)/' \
    | sed -e 's/ですすぐ/X de susugu (Y rinses Z with X)/' \
    | sed -e 's/が澄む/X ga sumu (X gets clear)/' \
    | sed -e 's/を搾り出す/X wo siboridasu (Y squeezes X)/' \
    | sed -e 's/に浸る/X ni hitaru (Y soaks in X)/' \
    | sed -e 's/がしみる/X ga simiru (X soaks into Y)/' \
    | sed -e 's/に浸す/X ni hitasu (Y dips Z in X)/' \
    | sed -e 's/を垂らす/X wo tarasu (Y drops X)/' \
    | sed -e 's/がほとばしる/X ga hotobasiru (X spurts)/' \
    | sed -e 's/を注ぐ/X wo sosogu (Y pours X)/' \
    | sed -e 's/が満ちる/X ga mitiru (X fills Y)/' \
    | sed -e 's/が溢れる/X ga ahureru (X overflows)/' \
    | sed -e 's/が流れ出る/X ga nagarederu (X flows out)/' \
    | sed -e 's/に浮く/X ni uku (Y floats on X)/' \
    | sed -e 's/を撒き散らす/X wo makitirasu (Y sprinkles X)/' \
    | sed -e 's/が流れる/X ga nagareru (X flows)/' \
    | sed -e 's/が溜まる/X ga tamaru (X gets collected)/' \
    | sed -e 's/が漏れる/X ga moreru (X leaks)/' \
    | sed -e 's/を撒く/X wo maku (Y scatters X)/' \
    | sed -e 's/をかける/X wo kakeru (Y sprays X)/' \
    | sed -e 's/を汲み取る/X wo kumitoru (Y scoops up X)/' \
    | sed -e 's/水/mizu (water)/' \
    | sed -e 's/油/abura (oil)/' \
    | sed -e 's/感情/kanjou (emotion)/' \
    | sed -e 's/泥/doro (mud)/' \
    | sed -e 's/情報/jouhou (information)/' \
    | sed -e 's/言葉/kotoba (word)/' \
    | sed -e 's/不満/human (complaint)/' \
    | sed -e 's/気持ち/kimoti (feeling)/' \
    | sed -e 's/音/oto (sound)/' \
    | sed -e 's/声/koe (voice)/' \
    | sed -e 's/砂/suna (sand)/' \
    | sed -e 's/空気/kuuki (air)/' \
    | sed -e 's/愛/ai (love)/' \
    | sed -e 's/悲しみ/kanasimi (sorrow)/' \
    | sed -e 's/におい/nioi (smell)/' \
    | sed -e 's/不安/huan (anxiety)/' \
    | sed -e 's/情熱/jounetu (passion)/' \
    | sed -e 's/憎悪/zouo (hatred)/' \
    | sed -e 's/喜び/yorokobi (delight)/' \
    | sed -e 's/怒り/ikari (anger)/' \
    | sed -e 's/光/hikari (light)/' \
    | sed -e 's/楽しさ/tanosisa (enjoyment)/' \
    | sed -e 's/金銭/kinsen (money)/' \
    | sed -e 's/恐怖/kyouhu (fear)/' \
    | sed -e 's/希望/kibou (hope)/' \
    | sed -e 's/快楽/kairaku (pleasure)/' \
    | sed -e 's/嫉妬/sitto (envy)/' \
    | sed -e 's/勇気/yuuki (bravery)/' \
    | sed -e 's/羞恥心/syutisin (shame)/' \
    | sed -e 's/意図/ito (intention)/' \
    | sed -e 's/絶望/zetubou (despair)/' \
    | sed -e 's/安心/ansin (relief)/' \
    | sed -e 's/時間/jikan (time)/' \
    | sed -e 's/アリ/ari (ant)/' \
    | sed -e 's/岩/iwa (rock)/' \
    | sed -e 's/労働/roudou (labor)/' \
    | sed -e 's/理解/rikai (understanding)/' \
    | sed -e 's/ケーキ/keeki (cake)/' \
    | sed -e 's/ネコ/neko (cat)/' \
    | sed -e 's/睡眠/suimin (sleep)/'
