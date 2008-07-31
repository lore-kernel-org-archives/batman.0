Message-ID: <47725.78.152.237.242.1217490038.squirrel@www.rivertowermail.com>
In-Reply-To: <489118AA.7020905@gmx.net>
References: <59864.212.147.148.167.1217448919.squirrel@www.rivertowermail.com>
	<489118AA.7020905@gmx.net>
Date: Thu, 31 Jul 2008 08:40:38 +0100 (IST)
Subject: Re: [B.A.T.M.A.N.] Multi-card MESH
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Elektra,

I wonder if I use an omni and a higher gain directional antenna would it
work itself out?  Longer distance links would find the directional
antennas would give a better association an hopefully less packet loss
while still having the same hop count.

Then again if the higher gain directional antennas all saw each other
(like with a higher node density) then it would end up being a single card
MESH system with unused cards and antennas.

I'm trying to find out if OLSR is the same with multi card systems

thanks

Derek

On Thu, July 31, 2008 2:43 am, elektra wrote:
> Hi -
>
>
>
>> Is it possible to use BATMAN with two backbone network cards?
>>
>
>
> multiple network interfaces are supported, but the current routing metric
> is based on packet loss and hop count, not actual throughput - this is
> likely to be suboptimal in some scenarios. Please go ahead and test if it
> does fit your purpose.
>
> cu elektra _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

