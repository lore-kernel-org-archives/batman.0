Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Jul 2009 21:54:13 +0800
References: <8c906fa50907160755g41d2e437m11fa02c7fdde8cfb@mail.gmail.com>
In-Reply-To: <8c906fa50907160755g41d2e437m11fa02c7fdde8cfb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907172154.13655.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] VIS labels
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


Hi,

> Also, which is the general criteria to know from which number, that
> the output shows, is considered a good, regular, bad or "imposible to
> use" link?

the number gives information about the link quality as batman measures it. 
1.00 means 100% link quality, 2.00 means 50%, etc. Basically the idea is that 
the number tells you how many packets you need to send in order to get a 
single successful transmission. HNA are announced networks which do not run 
batman.

The criteria for a good / bad / regular / etc link is rather subjective and 
depends on your demands. Do you need high throughput or just a few bytes per 
week ?  A live video stream over a link which looses more than 50% of the 
packets requires quite some patience.  ;-)

Regards,
Marek



