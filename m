MIME-Version: 1.0
In-Reply-To: <200902061001.59366.lindner_marek@yahoo.de>
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
	<20090204205611.GA13896@pandem0nium>
	<2ced936d0902050926r1f07cf85j405bf808f0bf3f7f@mail.gmail.com>
	<200902061001.59366.lindner_marek@yahoo.de>
Date: Fri, 6 Feb 2009 14:25:25 -0300
Message-ID: <2ced936d0902060925g3ab56154haee0bc6aac8ba5ff@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Stable adapters for Ad Hoc networks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello Marek,

   Have you managed to set a static BSSID to all those chipsets -
Atheros, Broadcom, Ralink etc? Because up to now, only Atheros made
this trick possible.

   If I managed to do that with the rt73 chipset that would be enough.
But the driver guys seem to have no documentation stating if this is
possible or not, and doing an iwconfig rausb0 ap <BSSID MAC> does not
change anything :/.

best regards,

2009/2/5 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>>      I still wonder if setting up a static BSSID will stop the BSSID
>> selection algorithm from ocurring. What do you think? Have tested this
>> in practice?
>
> yes, it will deactivate the selection algorithm. We used this hack to get=
 the
> Freifunk Berlin network stable. We had a real hardware zoo (Atheros, Broa=
dcom,
> Ralink, etc) that was impossible to control without setting the BSSID.
>
> Regards,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::
