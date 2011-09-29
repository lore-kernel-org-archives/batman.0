Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 29 Sep 2011 12:08:01 +0200
References: <3131360.5iACvcvJX2@ostrea>
	<201109271344.27161.lindner_marek@yahoo.de>
	<2034315.VHQ2Ikuuga@mytilus>
In-Reply-To: <2034315.VHQ2Ikuuga@mytilus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109291208.02457.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: loop caused by tinc and wifi
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, September 28, 2011 00:03:24 Bjoern Franke wrote:
> I don't know, yesterday one of the loop-routers crashed, so I was not able
> to test it yet.

Ok.


> BTW, how can I solve the MTU issue?

You probably can't. However, I don't think this is a critical problem. It only 
means that batman-adv will have to fragment the traffic.

Cheers,
Marek
