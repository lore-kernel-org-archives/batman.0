Message-ID: <4189.79.4.219.107.1237622287.squirrel@krisma.oltrelinux.com>
In-Reply-To: <49C49C1A.6050100@java-system.com>
References: <49C40762.3050109@java-system.com>
	<200903210917.54806.lindner_marek@yahoo.de>
	<49C49C1A.6050100@java-system.com>
Date: Sat, 21 Mar 2009 08:58:07 +0100 (CET)
From: "Antonio Anselmi" <a.anselmi@oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] What do you think of this result?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Marco

can you post the 802.11 and inet configurations of the involved iface
(I think wlan1) and a memory usage hwile batmand is running?

Antonio

On Sat, March 21, 2009 8:49, marco tozzini said:
> Marek Lindner wrote:
>> On Saturday 21 March 2009 05:15:14 marco tozzini wrote:
>>
>>> and this is the results
>>> 192.168.2.200 : xmt/rcv/%loss = 1000/928/7%, min/avg/max =
>>> 1.23/2.04/92.8
>>> 192.168.2.201 : xmt/rcv/%loss = 1000/759/24%, min/avg/max =
>>> 1.28/3.11/27.5
>>> 192.168.2.203 : xmt/rcv/%loss = 1000/766/23%, min/avg/max =
>>> 1.33/3.36/38.7
>>>
>>> I don't think it's normal, isn't it?
>>>
>>
>> What exactly are you referring to ? Are you wondering why the packet
>> loss of
>> fping is higher than predicted by batman ?
>>
>> Regards,
>> Marek
>>
>>
> Hi Merek
>  From batman debug output it seems batman station has a good view one
> to
> each other, but working on this systems is very annoying:
> ssh terminal has a wobbling response to commands
>
> Is this the behavior I shall expect from a good working mesh system?
>
> Ciao
> Marco
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


