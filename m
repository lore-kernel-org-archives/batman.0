Return-Path: <ajeetbbr@gmail.com>
MIME-Version: 1.0
In-Reply-To: <mailman.1937.1372756011.23063.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.1937.1372756011.23063.b.a.t.m.a.n@lists.open-mesh.org>
Date: Wed, 3 Jul 2013 10:43:05 +0530
Message-ID: <CAHQ_bgi8uDOnHWrfYU6-k7sL1Fd4P+-m9FtkUmpx11VuL4uH9A@mail.gmail.com>
From: ajeet singh <ajeetbbr@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Digest, Vol 79, Issue 1
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

> Message: 3
> Date: Tue, 2 Jul 2013 09:25:31 +0200
> From: Antonio Quartulli <ordex@autistici.org>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
>         <b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] ttcrc value
> Message-ID: <20130702072531.GA2325@ritirata.org>
> Content-Type: text/plain; charset="utf-8"
>
> On Tue, Jul 02, 2013 at 11:28:48AM +0530, ajeet singh wrote:
>> Hello all,
>> We are getting the same value of ttcrc always even after restarting the nodes.
>>
>> Please check the bellow TCPDUMP log,
>>
>> Log 1
>> 09:05:17.118462 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
>> f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
>> 50, v 14, flags [...F.], length 26
>> 09:05:17.118764 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
>> f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
>> 50, v 14, flags [...F.], length 26
>>
>> Log 2 ( After restart)
>>  00:12:29.480397 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
>> aa:aa:03:00:00:00, seq 2864163091, tq 255, ttvn 1, ttcrc 15939, ttl
>> 2, v 14, flags [.....], length 26
>>  00:12:29.520254 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
>> aa:aa:03:00:00:00, seq 31648486, tq 255, ttvn 1, ttcrc 15939, ttl 50,
>> v 14, flags [...F.], length 26
>>  00:12:32.488390 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
>> aa:aa:03:00:00:00, seq 2864163092, tq 255, ttvn 1, ttcrc 15939, ttl
>> 2, v 14, flags [.....], length 26
>>  00:12:32.536432 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
>> aa:aa:03:00:00:00, seq 31648487, tq 255, ttvn 1, ttcrc 15939, ttl 50,
>> v 14, flags [...F.], length 26
>>
>>
>>  Is it normal operation?
>
> The TTCRC is computed based _only_ on the address addresses listed in the local
> table. There is no randomness involved, therefore, if the addresses in the table
> are always the same, then also the TTCRC will stay the same.
>
> Is this the case?
>
> cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 836 bytes
> Desc: Digital signature
> URL: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/20130702/42977597/attachment-0001.sig>
>
Hello Antonio,

Thanks for reply.
I have fixed the MAC for bat0, so I am getting same ttcrc after every reboot.

Thanks
Ajeet
