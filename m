Message-ID: <32464.85.41.146.90.1189084222.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200709061331.03704.axel@open-mesh.net>
References: <26352.85.41.146.90.1189024539.squirrel@krisma.oltrelinux.com>
	<200709061331.03704.axel@open-mesh.net>
Date: Thu, 6 Sep 2007 15:10:22 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] something about 0.3
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hello Axel

thanks for your statements, especially for kernel module (which was
puzzling me). Changeing UDP port, however, make batman 0.2 nodes out of
the mesh so I'll update all nodes to 0.3 version (also if still no
stable... but sure the future).

ciao ciao

Antonio



> Hello Antonio,
>
> On Mittwoch 05 September 2007, a.anselmi@oltrelinux.com wrote:
>> I've downloaded and installed the 0.3 current for fonera-kamikaze
>> platform
>> and it seems work fine in a robin mesh cloud... but I've a problem which
>> I
>> don't well undestand.
>> When batmand starts it ask me for a /dev/batman (a modul kernel) which
>> would improve performance.
>> I never read before about /dev/batman, so, anyone can suggest where I
>> can
>> find more documentation?
>
> Well, we are currently sedulously working on improvements on the
> performance
> of batman in the areas of cpu consumption and path detection. The kernel
> module is an approach by Andreas and Marek to optimized cpu-load. You can
> safely ignore this message because having the kernel module installed is
> not
> mandatory. The idea is that if batman finds the kernel module it can be
> used
> by the userspace batmand. IMHO (as in most open-source projects) the
> documentation is always one step behind the latest development approaches.
> Thats why its in the development  and not in the stable stable folder.
>
>> I believe that the originator messages compatibility number was been
>> incremented in o.3 because a node running 0.2 doesn't see OGMs coming
>> from
>> batman o.3 nodes... is this correct?
>
> Actually the compatibility number has not been increased with
> batmand-0.3_alpa
> but the udp port number used by batman has changed.
> Simon has managed to convience IANA to reserve a dedicated port for batman
> which is now 4305 (see:  http://www.iana.org/assignments/port-numbers )
>
> ( Just in case you downloaded  batmand-exp_0.3, there the compatibility
> number
> has been increased because it contains some experimental routing concepts
> which are considered incompatible with the previous algorithm. Launch
> $batmand -v to get some feedback about the running version and
> compatibility
> number )
>
> ciao,
> axel
>
>> Thanks
>>
>> --
>> Antonio
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


