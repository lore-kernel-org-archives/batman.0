In-Reply-To: <20071009165849.GA27755@MAIL.13thfloor.at>
References: <20070608201844.GM20739@localhost>
	<200710090953.43820.axel@open-mesh.net> <470B45AE.40502@poelzi.org>
	<200710091450.50135.axel@open-mesh.net>
	<00C3015B-8933-42C5-975D-22FE7DCF83AF@lo-res.org>
	<20071009142902.GA23682@localhost>
	<D3647F7F-99FB-41D1-A8FA-27E1433860AE@lo-res.org>
	<1191947697.5559.34.camel@tara.firmix.at>
	<1604B24B-0850-4D3D-9319-FFAC27DA5A5B@lo-res.org>
	<20071009165849.GA27755@MAIL.13thfloor.at>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86CDBEDE-D966-4F59-BB38-49D366C9A67B@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Tue, 9 Oct 2007 19:30:55 +0200
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
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>



On Oct 9, 2007, at 6:58 PM, Herbert Poetzl wrote:

> On Tue, Oct 09, 2007 at 06:40:11PM +0200, Aaron Kaplan wrote:
>>
>> yep, I think so too! Definitely worth a try.
>
>> @Bertl: would you help us to get vserver running
>>         as the basis for olsr (mesh routing demon) tests?
>
> sure, but please get me some idea what you want to do
> first :)


ok, so we have the following issue (sorry): we want to test  
B.a.t.m.a.n (https://www.open-mesh.net/) and olsrd (http:// 
olsr.funkfeuer.at,  http://wiki.funkfeuer.at//index.php/Olsrd-ng) on  
our test server.
That test server has 8GB or RAM and is currently in repair.
The idea is that in order to create a massive test with many  
instances of olsrd or b.a.t.m.a.n. we need lots of virtual hosts,  
they should all be connected via a virtual network.
This network needs a possibility of (real) packetloss between each link.

Furthermore each instance needs its own routing table.

when?
anytime, we can start on some devel server with a few instances.
As soon as our 8GB RAM machine is repaired we should test it there.

best,
aaron.

