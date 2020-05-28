Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
Subject: Re: Network stops passing traffic randomly
References: <20200525083512.832.13419@diktynna.open-mesh.org>
 <c022e032-f283-8432-2d3e-3013cf91773b@coolheads.com>
 <1970963.L7oaDoOIKM@sven-edge>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <04932e2f-d727-46ce-ef68-2c79062cf196@coolheads.com>
Date: Thu, 28 May 2020 16:59:05 -0400
MIME-Version: 1.0
In-Reply-To: <1970963.L7oaDoOIKM@sven-edge>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: smartwires@gmail.com, greearb@candelatech.com



On 5/28/20 3:19 PM, Sven Eckelmann wrote:
> On Thursday, 28 May 2020 21:03:20 CEST Steve Newcomb wrote:
>> I have seen Sven's remark about unicast packets.  I'm not sanguine about
>> getting Qualcomm to fix a driver for an older product.
> I am slightly confused now about the mentioning of the candelatech driver.
>
> Just to sync both of you up:
>
> * Are you using ath10k-ct with the ath10k-firmware*-ct or are you using a=
th10k
>    with the ath10k-firmware*?
> * And are you using IBSS or 802.11s (meshpoint with mesh_fwding=3D0)? Is =
this
>    encrypted or not encrypted?
Speaking only for myself:

CONFIG_PACKAGE_ath10k-firmware-qca988x=3Dy
CONFIG_PACKAGE_kmod-ath10k=3Dy
# CONFIG_PACKAGE_ath10k-firmware-qca988x-ct is not set
# CONFIG_PACKAGE_kmod-ath10k-ct is not set

option mesh_fwding '0'
option encryption 'psk2+ccmp'

>
>> The Candela
>> Technologies driver refuses to function on the DFS channels (100, 116,
>> 132), which in my large, populous US residential environment work far,
>> far better than channels 36 or 149.
> Was this reported to Ben Greear?
Not yet, no.=A0 I am planning to do that when I can get serious about=20
testing the adhoc alternative.=A0 I tried it just long enough to discover=20
that DFS didn't work (log message was something like "forbidden" (can't=20
remember exactly what it said right now, but that was the sense of it),=20
although I had specified country 'US' and the driver seemed to be aware=20
of the corresponding hex code.=A0 No such log message appeared when=20
channel was 36 or 149.=A0 I said to myself: hmmm, at least the QCA driver=20
*sort-of* works in my environment and returned to it.
>
> Kind regards,
> 	Sven

