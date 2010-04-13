Return-Path: <fboehm@aon.at>
Message-ID: <4BC41A73.7050508@aon.at>
Date: Tue, 13 Apr 2010 09:17:07 +0200
From: =?ISO-8859-15?Q?Franz_B=F6hm?= <fboehm@aon.at>
MIME-Version: 1.0
References: <4BC2CB9E.4050309@aon.at> <20100412183858.GA9739@pandem0nium>
In-Reply-To: <20100412183858.GA9739@pandem0nium>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Patch batman-adv for kernel 2.6.15
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,

I already thought it's much more difficult because otherwise someone=20
else would have written a patch already :-) Perhaps I have to stay with=20
batman-adv 0.1 the next time.

I am very unfamiliar with this kernel locking and work queueing voodoo.=20
But those techniques already existed before 2.6.20 so shouldn't there be=20
a quite simple solution?

Regards,
Franz


Simon Wunderlich schrieb:
> Hello Franz,
>
> the workqueues are the most "non-trivial" thing which prevented us so far
> from backporting batman-adv to these older kernel. I'd also be interested=
=20
> to integrate patches if anyone has a solution for this. :)
>
> best regards,
> 	Simon
>
>
> On Mon, Apr 12, 2010 at 09:28:30AM +0200, Franz B=F6hm wrote:
>  =20
>> Hi,
>>
>> I am trying to get batman-adv (kernelland) running on Ubiquiti Networks =
=20
>> hardware. Unfortunately the Ubiquiti SDK uses kernel 2.6.15 and =20
>> batman-adv needs at least 2.6.20. I did have some success in patching =20
>> and running batman-adv-kernelland 0.1 (r1176). I would of course prefer =
=20
>> using batman-adv 0.2 but I do have problems implementing the older =20
>> kernel workqueue API.
>>
>> Perhaps someone can give me a hint on porting for example this function =
=20
>> from send.c to the old workqueue API.
>>
>> void send_outstanding_bat_packet(struct work_struct *work)
>> {
>>    struct delayed_work *delayed_work =3D
>>        container_of(work, struct delayed_work, work);
>>    struct forw_packet *forw_packet =3D
>>        container_of(delayed_work, struct forw_packet, delayed_work);
>>    unsigned long flags;
>>
>>    spin_lock_irqsave(&forw_bat_list_lock, flags);
>>    hlist_del(&forw_packet->list);
>>    spin_unlock_irqrestore(&forw_bat_list_lock, flags);
>>
>>    send_packet(forw_packet);
>>
>>    /**
>>     * we have to have at least one packet in the queue
>>     * to determine the queues wake up time unless we are
>>     * shutting down
>>     */
>>    if ((forw_packet->own) &&
>>        (atomic_read(&module_state) !=3D MODULE_DEACTIVATING))
>>        schedule_own_packet(forw_packet->if_incoming);
>>
>>    forw_packet_free(forw_packet);
>> }
>>
>> Kind regards,
>> Franz
>>
>>    =20
