Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <580FE89F.1090808@yahoo.com>
Date: Wed, 26 Oct 2016 07:19:59 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: Whether Batman-adv need suitable wifi network card (support
 interface modes ( mesh point ) ) .
References: <580F251E.7060400@yahoo.com> <2155840.zTA8OrSqiX@bentobox>
In-Reply-To: <2155840.zTA8OrSqiX@bentobox>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hello Sven:

Thanks you for your advisement , and i will start via two Rt2070 at 
first , but i will purchase suitable wifi network card or wifi module 
recently ,

Whether Atheros (AR54xx、AR91xx、AR92xx、AR93xx及AR95xx) will be 
suitable for batman-adv ?

their driver is ath9k .


Have a good day with you

Best Regards

Tiger

于 2016年10月25日 17:45, Sven Eckelmann 写道:
> On Dienstag, 25. Oktober 2016 17:25:50 CEST johnzeng wrote:
>> Hello Dear Sir :
>>
>> Whether Batman-adv need suitable wifi network card (support interface
>> modes ( mesh point ) ) .
> "mesh point" is for 802.11s. You can use 802.11s (mesh point) interfaces
> for batman-adv when you set mesh_fwding to 0. But most people use IBSS
> (adhoc) at the moment for batman-adv. It doesn't really care that much
> about the underlying interface. It just has to be ethernet compatible
> and support some basic features like broadcast.
>
> So you could even run infrastructure mode (AP+Sta) with batman-adv. But
> it doesn't make a lot of sense in most situations :)
>
> The B.A.T.M.A.N. V algorithm implementation has some extra requirements.
> It must be able to get the expected throughput towards a different device
> from cfg80211. You can check if the driver supports this by checking
> `iw dev wlan0 station dump` and searching for "expected throughput:".
> The Mpbs value should represent the reality (and not be complete bogus).
>
> The biggest problems here are driver/hw bugs. Even the ath9k hardware
> (which works quite well) has its fair share of problems.
>
>> there are two wifi network card , and i thought Rt2070 will support
>> Batman-adv .
>>
>> Because Rt2070 will support interface modes ( mesh point ) , and
>> RTL8188CUS can't support interface modes based mesh point .
> Both advertise support for IBSS. So you can (in theory) use adhoc on
> both devices and run batman-adv on top of these adhoc interfaces. But
> you may end up with driver problems (at least I already had problems
> with Realtek and Ralink hardware). Maybe someone else here already
> tested these two chips and tell us more about them.
>
> Kind regards,
> 	Sven

