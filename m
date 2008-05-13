Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <200805131634.20052.lindner_marek@yahoo.de>
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805081812.33117.lindner_marek@yahoo.de>
	<CB4F1B6A-15D9-4CFD-BA29-4B6AC6F72596@cslab.ece.ntua.gr>
	<200805131634.20052.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
Content-Transfer-Encoding: 7bit
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Tue, 13 May 2008 12:14:12 +0300
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


On May 13, 2008, at 11:34 AM, Marek Lindner wrote:

>
> Hi,
>
>> I went the other way round and started out on an external program  
>> that
>> will act as an interface between batman and quagga. You can find it
>> here:
>>
>> http://www.cslab.ece.ntua.gr/~chazapis/batman/batquagga-0.1.c
>
> cooool !
>
>
>> Do you keep or plan to keep network HNA information in batmand?
>> I mean, is there any way that flush_routes_rules (in linux/route.c)
>> could
>> be implemented in batmand, without the need of the external routing
>> table management?
>
> Batman keeps track of the HNA and all other routes which were  
> placed by batman
> and deletes them individually. The mentionned function  
> flush_routes_rules()
> is only called during the startup to clean the tables and in case of a
> segmentation fault because the internal data structures can't be  
> trusted
> anymore. The normal case is that batman deletes its own routes one  
> by one.
>

That's great. My apologies I couldn't find that before.

> I did some testing with a script which just prints the commands and  
> I noticed
> that the script can't execute those commands because it dies too  
> quickly via
> SIGINT or SIGTERM. Therefore the latest revision (1065) ignores these
> signals. Apart from that we have a little sync problem. Batman  
> kills its
> child after sending all the commands via the pipe. At that moment  
> the child
> may still be busy with processing these commands. We have to find  
> an elegant
> way to communicate that the child finished its last job. The latest  
> revision
> waits another 3 seconds which is far from being perfect ...
>

I will take a look at that and see if I can do anything.

Thanks!

Antony

> Greetings,
> Marek
>
> PS: Your addtional script arguments patch is an interesting idea.  
> We are
> checking on that because it might have some side effects.
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

