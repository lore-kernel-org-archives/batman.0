Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Dec 2009 10:48:17 +0800
References: <20091203002407.GA10048@Linus-Debian> <4B172691.8010707@gmail.com>
In-Reply-To: <4B172691.8010707@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912031048.17909.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Updating orig_str for debug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi Gus,

> Shouldn't the "addr_to_string(orig_str, orig_node->orig);" be moved out
> side the loop to near the top of the function? There is only one
> originator node and there is no reason to iterate over it. One time
> should suffice.

you are probably right but I know that Andrew has a patch in his pipeline 
which will remove these addr_to_string() calls entirely (printk can handle mac 
addresses for us). Until then we can live with this workaround. :)

Regards,
Marek
