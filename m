Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130420135636.GB5732@ritirata.org>
References: <CAP5XTDOompgC27u857UaC6UZ6pk1mg6BnLdtsEL1uMgMq452bw@mail.gmail.com>
 <20130419123826.GB13226@ritirata.org>
 <CAP5XTDM4yWxbjEDSDkAyAuizLQDh97Ea616tGOs-dS5YBKgX-A@mail.gmail.com>
 <20130420135636.GB5732@ritirata.org>
Date: Sat, 20 Apr 2013 20:39:53 +0300
Message-ID: <CAP5XTDOtNW6yDEAcRG=vArcxyRTh-M3vQJmL6DkoENDhmjZXOA@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFCv3] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 20 April 2013 16:56, Antonio Quartulli <ordex@autistici.org> wrote:
> On Fri, Apr 19, 2013 at 09:39:17 +0300, Mihail Costea wrote:
>> On 19 April 2013 15:38, Antonio Quartulli <ordex@autistici.org> wrote:
>> >
>> > I think this define is pretty overkill..What about creating a function which
>> > only takes care of converting a generic DHT data in a string. Later you can
>> > invoke this function when you want to print an IPv4/6 using batadv_dbg.
>> >
>> > Here is an example:
>> >
>> > char *batadv_dat_data_to_str(struct batadv_dat_entry *dat_entry,
>> >                              const char *buf, size_t buf_len)
>> > {
>> >         /* do something and put the string representation of the entry in the
>> >          * buf, without exceeding buf_len.
>> >          * Remember to use IS_ENABLED(CONFIG_IPV6) inside
>> >          */
>> >
>> >
>> >         return buf;
>> > }
>> >
>> > Then you can call it directly as parameter of a batdv_dbg function. E.g:
>> >
>> > batadv_dbg(....," %s\n", batadv_dat_data_to_str(entry, buf, buf_len));
>> >
>> > I think this approach would be better and easy to extend for future data types.
>> > If you like this approach, what do you think about sending a patch now to add
>> > this function to the current code?
>> >
>>
>> This could work. buf could be a string with a given pattern inside
>> (let's say %data, or something similar) that would be automatically
>> converted to the right type (like %pI4, or %pI6c.
>
> mh..I did not quite get this..If you know how to implement this "pattern
> substitution" you can send a patch with that. Otherwise what I proposed above is
> just another way of doing that, which is at least simpler and easier to read
> than the macro you proposed before (imho)
>
>
> Cheers,
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara

I think I just understood what you meant. Use that function just for
the data member of dat_entry and in rest keep everything as it is.
That makes stuff easier than the way I thought it.

Thanks,
Mihail Costea
