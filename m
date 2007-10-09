Date: Tue, 9 Oct 2007 16:29:02 +0200
From: Benjamin Henrion <bh@udev.org>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Message-ID: <20071009142902.GA23682@localhost>
References: <20070608201844.GM20739@localhost>
	<200710090953.43820.axel@open-mesh.net> <470B45AE.40502@poelzi.org>
	<200710091450.50135.axel@open-mesh.net>
	<00C3015B-8933-42C5-975D-22FE7DCF83AF@lo-res.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00C3015B-8933-42C5-975D-22FE7DCF83AF@lo-res.org>
Sender: Benjamin Henrion <zoobab@ffii.org>
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
Cc: Petrovitsch Bernd <bernd@firmix.at>

Aaron Kaplan <aaron@lo-res.org> [071009]:
> 
> Just yesterday I had a brief talk with Herbert from vserver. He  
> mentioned that it should be ok to use different routing tables in  
> each vserver instance. If this works out then I would like to know if  
> vserver is a viable alternative. Vserver is very low overhead. One of  
> the problems that I had with UML is the high (soft-)IRQ load.
> this produces permanent context switches and no work gets done. (if  
> you start 1000 instances that is!) :)
> 
> Can somebody test what happens if you start many instances in openVZ  
> and vserver?

Many = which number?

I have started 10 of those, and it works fine on a 1500Mhz machine with
512MB of RAM on a livecd system with minimal debian filesystems on a
harddisk.

--
Benjamin Henrion <bhenrion@ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
