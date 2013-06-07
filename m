Return-Path: <gtolon@inti.gob.ar>
Message-ID: <51B1F062.3060101@inti.gob.ar>
Date: Fri, 07 Jun 2013 11:38:26 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <20130604051326.GJ1226@ritirata.org>
 <20130604053841.GK1226@ritirata.org> <51AF567A.7030404@inti.gob.ar>
 <51AF58F4.8080501@inti.gob.ar> <20130606055102.GH1789@ritirata.org>
 <51B0D294.4070809@inti.gob.ar> <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar> <20130606191823.GJ1789@ritirata.org>
 <51B1E4D6.5000900@inti.gob.ar> <20130607135713.GL1789@ritirata.org>
In-Reply-To: <20130607135713.GL1789@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,


El 07/06/13 10:57, Antonio Quartulli escribió:
> Hi Gabriel,
>
> thank you for your logs
>
> On Fri, Jun 07, 2013 at 10:49:10AM -0300, Gabriel Tolón wrote:
>>>
>>> Hello Gabriel,
>>> there is a lot of noise because you are also generating traffic on the network.
>>> However I can see the ICMP Echo Request and then an Echo Reply, therefore the
>>> two nodes seem to be exchanging ICMP packets correctly.
>>>
>>> I'm checking again to try to understand what went wrong.
>>>
>>> Meanwhile, can you please report the output of
>>> "batctl l"
>>> during a bw test after having set the bw_meter log level by running
>>> "batctl ll bwm" ?
>>>
>>> To get the exact log of one test, you can first run batctl l (this will print
>>> all the past log), then you run the test and then you run batctl l again to
>>> obtain the interesting log. Please upload it on pastebin too.
>>>
>>> Thanks a lot!
>>>
>>
>> Sure, here they are:
>>
>> http://pastebin.com/fLu9hsyt
>>
>
>
>  From this log I can see that the protocol is entering Fast Retransmit many times
> and this happens due to reordering or small losses (the latter option is more
> realistic on a single hop network - but is it really one hop? I never asked).

Yes, it's one hop. Just two routers at a distance of 2 meters. They have 
two radios, but in the last tests I've unloaded one of them (the 5 Ghz 
one) to make it simpler, so they see each other just by one radio interface.

>
> The other strange thing I see is the final SRTT value which is 260ms and looks
> pretty high. Is there anything else going on the network (other traffic or..)?

Mmm, I don't know what's that SRTT, but no, there shouldn't be anything 
else in the air, at least not from me. But If there were interference or 
something like that, normal iperf would be slower I guess.

Besides, now I've tested connecting my PC via Ethernet to log avoiding 
interference from myself, also unloading the 2GHz, and loading the 5GHz 
in the routers (the 5GHz band should be cleaner), and the batctl bw 
keeps with slower values than iperf, 5Mbps this time.

If you want I could sniff the air with wireshark or something.

Maybe other possibility could be testing the bw meter connecting the 
routers by etnernet and not wirelessly?

Just for curiosity, you have already tested this on other scenarios and 
worked OK?


Regards

Gabriel



