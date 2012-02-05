Return-Path: <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Sun, 05 Feb 2012 18:44:22 +0100
Message-ID: <2542215.xqrqeDZyYX@g10h4cklab>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1406835.BNOUSKOx7d"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] Fwd: Re: batctl set different bw not the one passed
	as paramenter
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1406835.BNOUSKOx7d
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


--nextPart1406835.BNOUSKOx7d
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: Gioacchino Mazzurco <gmazzurco89@gmail.com>: Re: [B.A.T.M.A.N.] batctl set different bw not the one passed as paramenter

From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] batctl set different bw not the one passed as paramenter
Date: Sun, 05 Feb 2012 18:44:07 +0100
Message-ID: <4963933.DQpvZogYp2@g10h4cklab>
User-Agent: KMail/4.8.0 (Linux/3.0.6-gentoo; KDE/4.8.0; x86_64; git-4581a17; 2012-01-28)
In-Reply-To: <1723771.EVlpUnIhZa@sven-laptop.home.narfation.org>
References: <26576244.EFS60i6JSc@g10h4cklab> <1723771.EVlpUnIhZa@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

So there is no solution

Thanks anyway ;)

On Sunday 05 February 2012 18:41:38 you wrote:
> On Sunday 05 February 2012 18:34:39 Gioacchino Mazzurco wrote:
> > as in subject
> > 
> > eigenServer gioacchino # batctl gw server 10MBit/5MBit
> > eigenServer gioacchino # batctl gw
> > server (announced bw: 8MBit/5MBit)
> > 
> > why?
> 
> Because it works similar to wifi coverage when you use `iw phy phy0 set
> distance 10`. You ask for a bandwidth and this bandwidth is encoded in a
> binary word not large enough to store (10 * 2**20) or (5 * 2**20). So you
> end up with a information that is only similar to the input you gave.
> 
> Kind regards,
> 	Sven
--nextPart1406835.BNOUSKOx7d--

