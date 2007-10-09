Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
From: Bernd Petrovitsch <bernd@firmix.at>
In-Reply-To: <D3647F7F-99FB-41D1-A8FA-27E1433860AE@lo-res.org>
References: <20070608201844.GM20739@localhost>
	<200710090953.43820.axel@open-mesh.net> <470B45AE.40502@poelzi.org>
	<200710091450.50135.axel@open-mesh.net>
	<00C3015B-8933-42C5-975D-22FE7DCF83AF@lo-res.org>
	<20071009142902.GA23682@localhost>
	<D3647F7F-99FB-41D1-A8FA-27E1433860AE@lo-res.org>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 18:34:57 +0200
Message-Id: <1191947697.5559.34.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

On Die, 2007-10-09 at 16:56 +0200, Aaron Kaplan wrote:
> with UML i had 1500 instances in parallel

There should be much more possible since olsrd uses way less (> 30% or
so)
CPU time (and probably RAM - no one ever measured that AFAIK really. But
Hannes killed code and lots of malloc()s/free()s) than 3 months ago.

As for Vserver: Yes, that might be another trial worth (especially if
the vservers 99% identical) but AFAIK it needs a patched kernel.
And "Vserver on UML": Herbert should know better if one can mange to
run that. At least playing around is less risky.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


