Message-Id: <E062161D-1C70-4104-AE6D-8A1EE2767CFB@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
In-Reply-To: <20081205195131.GA27271@pandem0nium>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"; delsp="yes"
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory
	corruption bug
Date: Fri, 12 Dec 2008 22:08:01 +1300
References: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
	<20081204113558.GA14932@pandem0nium>
	<C12B8956-7F83-4FBE-A300-B803928CB64C@gmail.com>
	<20081205195131.GA27271@pandem0nium>
Content-Transfer-Encoding: quoted-printable
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

On 6/12/2008, at 8:51 AM, Simon Wunderlich wrote:

> Hey Scott,
>
> On Fri, Dec 05, 2008 at 11:40:30PM +1300, Scott Raynel wrote:
>> Hi Simon,
>>
>> On 5/12/2008, at 12:35 AM, Simon Wunderlich wrote:
>>
>>> Hey Scott,
>>>
>>> thank you very much for the fix! Can you confirm if this bug is
>>> related
>>> to https://dev.open-mesh.net/batman/ticket/86 ?
>>> This bug has very likely been caused by a memory corruption, but i
>>> couldn=C3=82=C2=B4t find where. (i have not experienced any kernel pani=
cs by
>>> this
>>> however ...).
>>
>>
>> It is quite possible that they are related. The slab error states =20
>> that
>> a memory allocation was overwritten - the same problem as my patch
>> fixed. However, I can't confirm whether it is the same memory
>> allocation or a different one. The stack trace I got specifically
>> mentioned the kfree() in send_own_packet(), whereas this stack trace
>> does not.
>>
>> Is that bug easily reproducible? It will be a couple of days before I
>> can try to look at it.
>
> Yep, it was quite easy: just turn it on and off a few times. (echo
> device and nothing into /proc/net/batman-adv/interfaces). The warning
> appeared after 10 times in my qemu instance. No crash, only this =20
> warning.

I can't reproduce this bug before my patch is applied because the bug =20
it fixes always gets in the way :)

After applying the patch I seem to be able to consistently lock up the =20
system by adding and removing an interface from the batman device =20
several times. The box still replies to pings, but I can't SSH in. =20
This does not trigger the slab debugger. I've looked at using the =20
magic sysreq interface to see what's going on and by printing the =20
current task it appears to be hanging during the =20
cancel_rearming_delayed_work() call in shutdown_module(). This might =20
be related to the scheduling-while-atomic bugs. I'll keep looking into =20
this as I get time, but things are pretty busy here at the moment.

Cheers,


--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand




