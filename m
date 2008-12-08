Message-ID: <493CDAD8.10400@irt.de>
Date: Mon, 08 Dec 2008 09:29:12 +0100
From: Tobias Gieseke <gieseke@irt.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Looking for batman-adv 0.1-alpha
References: <4938F21D.2050907@irt.de> <20081205200414.GB27271@pandem0nium>
In-Reply-To: <20081205200414.GB27271@pandem0nium>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Simon,

and thanks for the helpfull informations so far. As there is a command 
"batmand-adv" available on the meshnode i assume they use the userspace 
version of batman-adv (correct??). Can i copy the executeable file from 
the meshnode to my desktop an run it??
I'd really like to use the current version of the kernelland but i loose 
the warranty of the meshnodes if i make any changes on the command shell 
via ssh or serial port :-( I will think about that when i've finished my 
tests ;-)

Sorry, but my question to open-wrt was not precise enough. I wanted to 
know if there is a chance to get batmand-adv running on open-wrt with 
broadcom wifi. AFAIK batmand-adv is only running on kernel 2.6 but with 
kernel 2.6 broadcom wifi is not running on open-wrt (according to the 
open-wrt homepage).  Maybe you know a trick to get batmand-adv running 
on the Linksys WRT54GL or the Buffalo WHR-HP-G54 WiFi-Router, with WiFi 
running of course.


Kind regards,

Tobias




Simon Wunderlich schrieb:
> Hey Tobias,
>
> are you using the kernelland or userspace version of batman-adv? If you
> want to use the userspace version, it's enough to compile and copy the
> binary from your desktop to the meshnode (it's i386 after all). 
>
> However i'd recommend to use the latest revision of
> batman-adv-kernelland. For this you'd need to compile the modules for
> the kernel. AFAIK they use a debian based system, so you could probably
> use our Debian packages:
>
> http://packages.debian.org/sid/batman-adv-source
> http://packages.debian.org/sid/batman-adv-battool
>
> (you'd need their kernel source packages to compile it, thou ...)
> Please note that the userland version was intended as proof of concept 
> and we might only support the kernelland version in the long term.
>
> OpenWRT also supports batman-adv btw. :)
>
> best regards,
> 	Simon
>
> On Fri, Dec 05, 2008 at 10:19:25AM +0100, Tobias Gieseke wrote:
>   
>> Hi,
>>
>> I'm looking for Batman-advanced 0.1-alpha (compability version 1). We've 
>> got some meshnodes III from a company called Saxnet and they seem to 
>> work with this old version.. I can't find it in the repositories so 
>> perhaps someone can tell me where to find it, or send it to me directly. 
>> I need it for i386 architecture.
>> Is there a chance to get batman-adv running on open-wrt?
>>
>> kind regards,
>>
>> Tobi
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>     
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>     
