Return-Path: <aaron@lo-res.org>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <7iocnez3p1.fsf@lanthane.pps.jussieu.fr>
Date: Sun, 8 Nov 2009 00:35:39 +0100
Content-Transfer-Encoding: 7bit
Message-Id: <3F4B7F12-DB83-4483-AE6F-4B615E3A0AFE@lo-res.org>
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
	<200911071842.08599.lindner_marek@yahoo.de>
	<7iocnez3p1.fsf@lanthane.pps.jussieu.fr>
Subject: Re: [B.A.T.M.A.N.] [Olsr-users] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
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
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Cc: olsr list users mailing <olsr-users@lists.olsr.org>, The Ad-hoc Networking list for a Better Approach To Mobile <b.a.t.m.a.n@lists.open-mesh.net>, jerryw@uow.edu.au, babel-users@lists.alioth.debian.org, Marek Lindner <lindner_marek@yahoo.de>, brett_hagelstein@uow.edu.au, mehrana@uow.edu.au

I would have liked to see a comparison with OLSR.org default settings  
(ETX metric) instead of
hopcount metric. As Henning already pointed out, hop count metric is  
not useful at all and was long abandoned.

Nobody in our freifunk/funkfeuer networks actually uses hopcount and  
therefore we could achieved mesh sizes of 1000+ nodes *in practice*  
with OLSR.

a.


On Nov 7, 2009, at 5:42 PM, Juliusz Chroboczek wrote:

>>> 4. They ran the routing daemons with the default parameters.  This  
>>> means
>>>   that BATMAN ran with an OGM interval of 1 second, while Babel used
>>>   a Hello interval of 4 seconds.
>
>> Although I get your point, you probably share my belief in default  
>> options,
>> hence it is the right thing to compare.
>
> Fully agreed -- I would have liked to see a comparison with similar
> parameters *in addition* to the comparison with the default  
> parameters.
>
>                                        Juliusz
>
> -- 
> Olsr-users mailing list
> Olsr-users@lists.olsr.org
> http://lists.olsr.org/mailman/listinfo/olsr-users

