Return-Path: <gtolon@inti.gob.ar>
Message-ID: <51B0D294.4070809@inti.gob.ar>
Date: Thu, 06 Jun 2013 15:19:00 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <51A3C7E9.7080208@inti.gob.ar>
 <20130528070057.GC3333@ritirata.org> <51ACBCE4.8000506@inti.gob.ar>
 <20130603160813.GC1226@ritirata.org> <51AD0277.1060907@inti.gob.ar>
 <20130604051326.GJ1226@ritirata.org> <20130604053841.GK1226@ritirata.org>
 <51AF567A.7030404@inti.gob.ar> <51AF58F4.8080501@inti.gob.ar>
 <20130606055102.GH1789@ritirata.org>
In-Reply-To: <20130606055102.GH1789@ritirata.org>
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,


El 06/06/13 02:51, Antonio Quartulli escribió:
> Hello Gabriel,
>
> On Wed, Jun 05, 2013 at 12:27:48PM -0300, Gabriel Tolón wrote:
>>
>> Sorry, I sent the mail incomplete,
>>
>> So these are the routes:
>>
>> Equipo1:
>>
>> root@Equipo 1:~# batctl o
>> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:42 (bat0)]
>>     Originator      last-seen (#/255)           Nexthop [outgoingIF]:
>> Potential nexthops ...
>>             E3-5GHz    0.680s   (251)           E3-5GHz [   wlan1-1]:
>>          E3-5GHz (251)
>>             E3-2GHz    0.430s   (255)           E3-5GHz [   wlan1-1]:
>>          E3-5GHz (255)           E3-2GHz (252)
>>
>>
>> Equipo3:
>>
>> root@Equipo 3:~# batctl o
>> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:d6 (bat0)]
>>     Originator      last-seen (#/255)           Nexthop [outgoingIF]:
>> Potential nexthops ...
>>             E1-2GHz    0.310s   (255)           E1-5GHz [   wlan1-1]:
>>          E1-5GHz (255)           E1-2GHz (255)
>>             E1-5GHz    0.550s   (255)           E1-5GHz [   wlan1-1]:
>>          E1-5GHz (255)
>>
>
> routing tables look good. I am wondering where the problem can be..
> Can you try to do a "batctl td wlan0-1" while pinging? this may help to
> understand where the process is blocking.
> It would be helpful if you could do that on both the nodes while pinging in only
> one direction This way we see who receives what.

I did it, but the text files for the logs of the nodes with "batctl td" 
have a size of about 250 kB each one, with just 1 or 2 seconds logging. 
Is that too much for sending them to the list?

>
> (commit IDs are ok)
> Thank you very much for helping us in debugging this :)

No problem! I've asked things to this list many times and I've got 
useful answers, so I'm pleased to cooperate.

Regards

Gabriel
