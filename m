Return-Path: <itamar@itamar.org>
MIME-Version: 1.0
In-Reply-To: <53218FEB.8000100@meshcoding.com>
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
 <53218FEB.8000100@meshcoding.com>
Date: Thu, 13 Mar 2014 14:20:28 +0200
Message-ID: <CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>
From: Itamar Landsman <itamar@itamar.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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

Thanks Antonio,
I appreciate the quick reply.

batctl -v returns: batctl debian-2012.1.0-1 [batman-adv: 2013.2.0]

Should I compile and install from the latest git?
I see that the batctl command is from a much older release.. It
doesn't support the dat or dc parameters. Should I compile that one as
well?

Thanks again,
Itamar

On Thu, Mar 13, 2014 at 1:00 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
>
>
> On 13/03/14 10:24, Itamar Landsman wrote:
>> HI,
>> I am running a project using Raspberry pi machines that create a
>> batman-adv mesh.
>> Each of the rpis has three wifi devices. each of the wifi devices
>> hosts a separate ad-hoc network. This way I can get to work on three
>> separate channels and let batman worry about paths.
>>
>> My problem is that whenever I reboot a device, it comes back to life
>> but IP connection is never regained until; I reboot all other devices.
>>
>> I have tried to move the IP address from the bt0 interface to a bridge
>> interface that hosts br0 with no success.
>>
>> Any ideas?
>>
>> I am using the "Out of the box" batman-adv modules and batctl that
>> come with the most recent raspbian repo.
>
> Unfortunately I don't know what version of batman-adv is shipped iwth
> raspbian. Can you check the exact version by typing "batctl -v" ?
>
> This "issue" seems similar to something we already talked about in the
> past: it's a side effect of using DAT.
>
> DAT caches ARP entries, therefore when you reboot your node and bat0
> gets a "different" (randomly generated) MAC address, you should wait for
> all the other nodes in the network to drop their cached ARP entry and
> request the new one associated with your IP (this is a simplistic
> explanation of how ARP usually work).
>
> I hop I made the "issue" clear.
> You can check if you are really using DAT by typing "batctl dat".
>
> For more details about DAt, please check our wiki[1]
>
>
> Cheers,
>
>
> [1] http://www.open-mesh.org/projects/batman-adv/wiki/DistributedArpTable
>
> --
> Antonio Quartulli
>
