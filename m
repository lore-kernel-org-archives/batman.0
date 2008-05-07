Message-Id: <4A79C120-E22D-4EB4-91E9-851EA0B2DBE5@cslab.ece.ntua.gr>
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
In-Reply-To: <200805072041.54021.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 7 May 2008 16:00:14 +0300
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805072041.54021.lindner_marek@yahoo.de>
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


On May 7, 2008, at 3:41 PM, Marek Lindner wrote:

>
> Hi,
>
>> I have made a new version of the patch posted by acinonyx (rv502),
>> for interfacing batmand with the zebra routing daemon. There are 2
>> versions available: One for the latest svn (rv1060) and one for the
>> stable 0.3 release. Take a look at:
>>
>> http://www.cslab.ece.ntua.gr/~chazapis/batman/
>
> it looks good - thanks for your work. I would like to put your  
> changes on
> open-mesh.net. Either linking to your webspace or copying your work  
> on our
> server. What do you prefer ?
>

I would prefer that you copy it over. I think it is better to keep  
things in one place. :)

>
>> What the patch does is:
>> - Adds a flag "-z" to the batmand executable which may be used to
>>   enable zebra communication and accepts as an argument the
>>   path to the corresponding zebra unix-domain socket.
>> - If zebra is enabled:
>>   - No rules are added to the kernel.
>>   - All UNICAST routes are sent to zebra.
>
> Did you consider using the "--policy-routing-script" for this  
> communication
> with zebra ? You could write an external program that gets the  
> information
> from batman and relays them to zebra. Therefore, you would not need  
> to patch
> every batman installation and would not have to change your patches  
> every
> time when batman changes. By using this facility you can decide what  
> routes
> are sent to zebra, what routes are added to the routing table and  
> you don't
> need to worry about batman. This communication interface could also  
> be used
> by other routing protocols without the need of reinventing the wheel  
> over and
> over again.
>

I had a lengthy conversation about that with Acinonyx. The first patch  
I did was to
enable us to pass arguments to the policy routing script. However, I  
preferred a
direct patch, because I couldn't find an easy way with the current  
batmand and
(more importantly) the zebra interface to retrieve routes on exit. I  
had to
implement some kind of route management/tracking in the script and  
delete these
routes on shutdown. With the direct patch, route management is done in  
the kernel.
Sure, a full-featured policy-routing-script would be a more  
appropriate solution
and I hope to find some time to do it in the future.

An even greater challenge would be to implement a bidirectional policy- 
routing-script,
that could also be used to implement route redistribution from other  
protocols.
Which would of course require a full API to talk with batmand... Need  
even more time for that... :)

Cheers,

Antony

> Greetings,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

