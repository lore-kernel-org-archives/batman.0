Message-ID: <57655.149.5.32.200.1226965691.squirrel@www.rivertowermail.com>
In-Reply-To: <20081117220052.GB6516@pandem0nium>
References: <35301.149.5.32.200.1226956767.squirrel@www.rivertowermail.com>
	<20081117220052.GB6516@pandem0nium>
Date: Mon, 17 Nov 2008 23:48:11 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] Batman security
From: "Derek C" <derekbatman@hssl.ie>
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

Hi Simon,

I'll look into WPA-NONE (I haven't found much information yet all right). 
I'm just a bit concerned about no encryption at all - although you are
right about using a shared key when its fully considered).

I'm planning on controlling the MESH boxes myself and giving people free
broadband (I need to control the boxes because its very hard to get things
working exactly right).  But still - I'm sure some bright people will get
into a box and thats the key out.  But people worry about encryption, or
lack of, even if its flawed

Derek


On Mon, November 17, 2008 10:00 pm, Simon Wunderlich wrote:
> Hello Derek,
>
>
> no, there isn't something like this in BATMAN. You might want to have a
> look at WPA-NONE though, which can encrypt both data and routing traffic
> on the 802.11 layer for Ad-Hoc networks with TKIP or AES/CCMP (beware,
> it's pretty undocumented ...).
>
> For both, the OLSR security routing plugin (as far as i understood it)
> and WPA NONE, you have the problem of a shared, symmetric key. If each node
> has the key and you have a pretty decentralized setup, you might see your
> key on a website or ebay before you can even think about it. ;)
>
> So the first question should be what you secure against whom, which
> possible attackers are to be considered etc. We can discuss this further if
> you want. Not implementing a security feature in BATMAN was not only a
> design decision for minimalism, but we also could not find a scenario
> where this "protection" would be useful or would handle the situation
> better than conventional mechanisms.
>
> best regards, Simon
>
>
> On Mon, Nov 17, 2008 at 09:19:27PM -0000, Derek C wrote:
>
>> Hi all,
>>
>>
>> Is there any way to secure the traffic on the adhoc NIC with BATMAN -
>> like the secure plugin in OLSRd?
>>
>> thanks,
>>
>> Derek
>>
>>
>>
>> --
>> Derek C
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

