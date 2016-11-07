Return-Path: <martin@hundeboll.net>
Subject: Re: i have a question ? How many relay nodes can be supported at
 NetworkCoding ( mtu 1546 ) .
References: <581C7F4A.80104@yahoo.com> <2907018.3yHk8Vyvxo@sven-edge>
From: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@hundeboll.net>
Message-ID: <1e6c7958-6c5d-2b33-f3a6-2064963f88e6@hundeboll.net>
Date: Mon, 7 Nov 2016 08:37:35 +0100
MIME-Version: 1.0
In-Reply-To: <2907018.3yHk8Vyvxo@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, johnzeng <johnzeng2013@yahoo.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On 2016-11-05 15:28, Sven Eckelmann wrote:
> Hi,
>
>> When i compile the part , whether i need make
>> CONFIG_BATMAN_ADV_BATMAN_V=y at batman-adv-2016.2
>
> 2016.2 is "old". And BATMAN_V has nothing to do with network coding.
>
>> i read some detail about NetworkCoding , my understanding :
>>
>> every relay node will detects neighbors packet at promisc mode and
>> combine these packet into a single transmission ,
>
> I think Martin can help here. He also provided some documentation:
>
> * https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding
> * https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding-technical
> * https://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf
> * https://vbn.aau.dk/da/publications/catwoman(214ee21a-e786-495d-85c9-3efac4718ead).html
> * https://downloads.open-mesh.org/batman/misc/wbmv4-network_coding.avi

If you are looking into network coding as a research project, batman-adv 
is a fine starting point. But as Sven hinted in his answer, it isn't 
really useful in a real setup.

> And it will not try to forward each packet is overheard. Instead it
> will try to find coding opportunities which it then uses to forward
> its own packets in less transmissions (by using packets which the
> other nodes should already know).
>
>>               batctl nc 1
>>               echo 1 > /sys/class/net/bat0/mesh/network_coding
>>               ip link set dev wlan0 promisc on
>>               ip link set dev wlan0 mtu 1546
>
> Your cards/drivers will most likely not even support promiscuous mode.
> Some of them require to have an monitor mode interface at the same time and
> some of them will simply not work.
>
> You can test it by simply checking what tcpdump is showing you on the
> underlying interface (wlan0). If it doesn't show you the packets between
> two other nodes then promiscuous mode is not working for you.
>
> The feature itself is not used very often (Martin, please correct me here).

I don't use it myself, and don't know of anyone else using it.

> It is not enabled by default because it is not making things "better" all
> the time [1]. So it is also not tested as much as other components in
> batman-adv and you should think first if it is really useful for your
> scenario/HW. I knew at least from some Freifunk communities played around
> when it was enabled by default but had to revert when they experienced "non
> functional mesh links" (nothing more about it is known to me - sorry Martin).

No problem.

[snip...]

> network coding can only (when lucky) try to combine some packets - but
> this will only work when promiscuous mode is actually working and the
> nodes can overhear packets. Otherwise it will (in theory - Martin please
> correct me if I overlooked a safety mechanism) just create a lot of coded
> packets which cannot be decoded anymore.

Yeah, packets are lost if the nodes are not promiscuous.

Good luck with the project :)

// Martin
