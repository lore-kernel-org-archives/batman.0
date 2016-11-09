Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <58229D06.8030207@yahoo.com>
Date: Wed, 09 Nov 2016 11:50:30 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] i have a question ? How many relay nodes can be
 supported at NetworkCoding ( mtu 1546 ) .
References: <581C7F4A.80104@yahoo.com> <2907018.3yHk8Vyvxo@sven-edge>
 <mailman.63.1478602511.678.b.a.t.m.a.n@lists.open-mesh.org>
 <23104849.8bNq0ZtGq3@prime>
In-Reply-To: <23104849.8bNq0ZtGq3@prime>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>


Hello Dear Simon:

                               How will i do via batctl ? Do you mean 
that batman-adv can support it by default  at layer 2 ?

                               if Relay mode is based on Layer 2 ( route 
or Nat ) , it will be very complex and Infeasible at large wifi network

                               let's assume  the environment , node A  
can communicate with node B directly  via wifi and  node B can 
communicate with node C directly via wifi.

                               but node A can't communicate with node C 
directly via wifi ( master reason : Weak signal)  ,

                              Maybe Batman-adv can forward full 
Broadcast packet to next nodeC via nodeB , but if node A will build tcp 
connection between node A and nodeC ,

                              I can understand network coding , it will 
be same as proxy or Intermediator at Layer 2 ,


                             Your meaning :  Batman-adv can build 
Similar mechanism ( Intermediator )  via intermediator , it wil be  
relay based real application packet ( not relay based Broadcast packet)


                              Thanks

                              Best Regards

                              TIger
> On Tuesday, November 8, 2016 11:55:14 AM CET johnzeng via B.A.T.M.A.N wrote:
>> Hello Dear Sven and Martin:
>>
>>                                                Thanks for your advisement
>>
>>                                                I hope to aviod Excavation
>> of underground pipeline in the smart community or Park .
>>
>>                                                if Batman-adv can support
>> smart relay ( networking code ) at mesh network really , and it will be
>> very valuable for us .
> Hi Johnzeng,
>
> why are you insisting on using network coding? Batman-adv can do relay without
> network coding enabled, this is part of the basic mesh technology. Network
> Coding (or CATWOMAN) was research project/proof of concept implementation
> which isn't actively maintained right now. But from what I understood, your
> setups can be supported with "standard" batman-adv mesh.
>
> Thanks,
>      Simon
>
>>                                                i think one of  core
>> valuable point is  relay mode   and   Client roaming
>>
>>                                                i prepare to build more ap
>> evironment and test for the part  later
>>
>>
>>
>>
>> As market competition intensifies,
>>
>>                                                the gap between similar
>> productsis getting smaller and smaller,
>>
>>                                                likewise the evolution of
>> growing homogenization trends within the industry.
>>
>>
>>
>>                                                i hope we can find
>> valuable point for Blue Ocean each other .
>>
>>                                                if you have some different
>> point , and I would be happy to be the first and build win-win mode each
>> other .
>>
>>
>>                                                Best Regards
>>
>>                                                 Tiger
>>
>>> Hi,
>>>
>>>> When i compile the part , whether i need make
>>>> CONFIG_BATMAN_ADV_BATMAN_V=y at batman-adv-2016.2
>>> 2016.2 is "old". And BATMAN_V has nothing to do with network coding.
>>>
>>>> i read some detail about NetworkCoding , my understanding :
>>>>
>>>> every relay node will detects neighbors packet at promisc mode and
>>>> combine these packet into a single transmission ,
>>> I think Martin can help here. He also provided some documentation:
>>>
>>> * https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding
>>> *
>>> https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding-technica
>>> l *
>>> https://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.p
>>> df *
>>> https://vbn.aau.dk/da/publications/catwoman(214ee21a-e786-495d-85c9-3efac
>>> 4718ead).html *
>>> https://downloads.open-mesh.org/batman/misc/wbmv4-network_coding.avi
>>>
>>> And it will not try to forward each packet is overheard. Instead it
>>> will try to find coding opportunities which it then uses to forward
>>> its own packets in less transmissions (by using packets which the
>>> other nodes should already know).
>>>
>>>> batctl nc 1
>>>> echo 1 > /sys/class/net/bat0/mesh/network_coding
>>>> ip link set dev wlan0 promisc on
>>>> ip link set dev wlan0 mtu 1546
>>> Your cards/drivers will most likely not even support promiscuous mode.
>>> Some of them require to have an monitor mode interface at the same time
>>> and
>>> some of them will simply not work.
>>>
>>> You can test it by simply checking what tcpdump is showing you on the
>>> underlying interface (wlan0). If it doesn't show you the packets between
>>> two other nodes then promiscuous mode is not working for you.
>>>
>>> The feature itself is not used very often (Martin, please correct me
>>> here).
>>> It is not enabled by default because it is not making things "better" all
>>> the time [1]. So it is also not tested as much as other components in
>>> batman-adv and you should think first if it is really useful for your
>>> scenario/HW. I knew at least from some Freifunk communities played around
>>> when it was enabled by default but had to revert when they experienced
>>> "non
>>> functional mesh links" (nothing more about it is known to me - sorry
>>> Martin).>
>>>> if i send a packet from host A to hostC via hostB, whether hostB will
>>>> open relay mode at layer2 .
>>> I completely failed to parse this.
>>>
>>> batman-adv will send your data from hostA to hostC via hostB when the TQ
>>> value for the link "from hostA to hostC via hostB" is higher than the TQ
>>> value for the link "hostA to hostC directly". This has nothing to do with
>>> network coding and is a standard feature of batman-adv (this is actually
>>> what it is about).
>>>
>>> network coding can only (when lucky) try to combine some packets - but
>>> this will only work when promiscuous mode is actually working and the
>>> nodes can overhear packets. Otherwise it will (in theory - Martin please
>>> correct me if I overlooked a safety mechanism) just create a lot of coded
>>> packets which cannot be decoded anymore. This seems to be especially
>>> problematic when some nodes are for example 2x2 MIMO devices and others
>>> are 3x3. At least this would be a good way to let the 2x2 miss important
>>> packets when the 3x3 devices talk between each other.
>>>
>>> I would even guess that things like dynamic transmission power would make
>>> overhearing packets also more problematic.
>>>
>>>> but i have a question ? How many relay nodes can be supported at
>>>> NetworkCoding ( mtu 1546 ) .
>>> I am not sure what you are asking here. The implementation in batman-adv
>>> can combine two packets into one. And this combining of these two packets
>>> is done by exact one relay node. The decoding is done by the two receiving
>>> nodes. What you can build with it is been shown in the documentation from
>>> Martin. The network coding used here is therefore done by a relay node and
>>> its neighbors. But there can be multiple relay nodes in the mesh doing
>>> network coding at the same time.
>>>
>>>
>>> I personally haven't used network coding with batman-adv. But since you've
>>> created multiple new threads on the mailing list [1,2,3,4] (beside the
>>> private mail *grml*) - here is at least a pseudo-answer.
>>>
>>> Kind regards,
>>> Sven
>>>
>>> [1]
>>> https://www.open-mesh.org/projects/batman-adv/wiki/NetworkCoding#Drawback
>>> s [2]
>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016586.ht
>>> ml [3]
>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016587.ht
>>> ml [4]
>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016588.ht
>>> ml [5]
>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016592.ht
>>> ml
>> End of encapsulated message

