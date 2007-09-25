From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] routing / direct connection
Date: Tue, 25 Sep 2007 13:26:38 +0200
References: <46F26999.1010307@ddmesh.de>
	<200709212038.41280.axel@open-mesh.net>
	<46F8C16A.1010805@ddmesh.de>
In-Reply-To: <46F8C16A.1010805@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709251326.39010.axel@open-mesh.net>
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

Hi,
first thanks for your input,

> I shortly checked your writing and found some unclear points.
> - What is the difference (-d 1 ) of the viaIF and the viaIF of
> the optional info block?

I've tried to make this more concrete. 
http://open-mesh.net/batman/doc/BMX#debug-level-1-parameter
critic is still welcome.

>
> - the nlq = l2q / l2: what is l2?
Yes,  that was a flaw, I meant lq NOT l2. Anyway I renamed the terms a little 
bit so that it now reads:
NLQ = RTQ / LQ
where RTQ should be referred as  Round Trip Quality

> - you compare the lq with the OLSR-ETX. But can you explain it
>   without "OLSR-ETX", because I don't like to check the documentation
>   of OLSR
done

> -bidirectional timeout: is the number given in seconds or sequence count
> difference or something other?

in sequence number counts. I'll see to make this clearer as well.

>
> If haven't already planed, the options --dups-xxx --asymmetric-xxx and all
> that only have the blue bar needs more description and what influence they
> have within the batmand. Examples as you have offered by --window-size are
> very helpful.
on its way...


ciao,
axel

