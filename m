Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 6 Nov 2011 21:57:15 +0800
References: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
In-Reply-To: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111062157.15824.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] MTU issue
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


Hi,

> I had the same issue previously, but 1528 did not do it.
> I have since changed build on that unit and can't remember the actual
> value I used, But it was larger.
> 
> All I did was increase the value until the warning disappeared, and
> everything started working as advertised.

what do you mean with "working as advertised" ? It should work even if you get 
this warning. All it does is fragmenting your traffic.

Setting the MTU to 1528 works for me. Without providing more information about 
your setup and giving us the number which seemingly "fixed" it for you nobody 
can help you.

Regards,
Marek
