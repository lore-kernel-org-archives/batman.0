Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 27 Sep 2011 13:44:26 +0200
References: <3131360.5iACvcvJX2@ostrea>
	<201109261726.38951.lindner_marek@yahoo.de>
	<1997296.MKzYFvRXTH@mytilus>
In-Reply-To: <1997296.MKzYFvRXTH@mytilus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109271344.27161.lindner_marek@yahoo.de>
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

On Tuesday, September 27, 2011 12:45:01 Bjoern Franke wrote:
> ath1 (ad-hoc) as batman-interface
> br-mesh (ath0 (ap-mode), eth0.1, tap0, bat0) as batman-interface
> 
> batman complains about the mtu 1500 of br-mesh, but it can't be set to 1527
> because bat0 does not like any mtu setting.

Ok, does it solve your loop ?


> > We are working towards an enhanced bridge loop mechanism which aims to
> > reduce the overhead. Are you interested in testing it when it gets ready
> > ?
> 
> Yes, this would be nice :)

Great! We will contact you once we have something testable.

Cheers,
Marek
