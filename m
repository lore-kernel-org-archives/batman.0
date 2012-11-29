Return-Path: <lmy19901031@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg7F3MNsy5gtcP=pcd0R_tFUmCTsyZ-K9bYMnCf0-YmArQ@mail.gmail.com>
 <CALDpWg6BczTcB3g=njyTfTHGuuKODB8AkxrLguOyH8Y3nMB5yA@mail.gmail.com>
 <CALDpWg7qErZ=kEp8hE__tYw0oWpfLVrR2V_c3hCQ3wx33oaE1w@mail.gmail.com>
 <CALDpWg6aGx+6eKwhbYUaNKeaMhiwPUWwgKVj7Smw6+9HrmZ1gA@mail.gmail.com>
 <CALDpWg6ikWqdgEsEnuDUeU9S-AfDDWicuixoSZhO2GN5tQzHUA@mail.gmail.com>
 <CALDpWg5UinZxugVHYRyK70tUFTPQ7FHqRAsn0GP_gV=EZVMWtQ@mail.gmail.com>
 <CALDpWg5uoeERLHMawtLP5F5EC9Xvkyf5WAu7DVYwOXDw3fwfYw@mail.gmail.com>
Date: Thu, 29 Nov 2012 14:52:08 -0500
Message-ID: <CALDpWg6Ci0DDUs=Y8TKWn98uwLXnhG1Mdb5NEje1jdvJJoiFdA@mail.gmail.com>
From: liu muye <lmy19901031@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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

Hello:

By looking at the packet.h from the batctl source code. I found this:

#define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */

I guess it would be the packet type batman would recognized. When I
set the type to 0x4305.
However, I cannot even see any output from the receiver side when I
run batctl tcpdump bat0 on it.

Just wondering if you guys can have simple examples about the socket
programming on B.A.T.M.A.N.

Thank you so much


On Wed, Nov 28, 2012 at 9:49 PM, liu muye <lmy19901031@gmail.com> wrote:
> Hello:
>
> Now I switch to MAC address of bat0 as the source and destination
> address. In this case, I only have two nodes. Node A and node C.
>
> Now, I cannot send packet from node A to node C, and vice versa.
> However, when I do batctl tcpdump bat0 on the receiver side, I can see
> print out shown in the following.
>
> Warning - packet contains unknown ether type: 0x1337.
>
> Not sure what should I do now.
>
> Thanks
>
> On Wed, Nov 28, 2012 at 7:09 PM, liu muye <lmy19901031@gmail.com> wrote:
>> Yes. Thanks for your help. I will try the way you suggested.
>>
>>
>>
>> On Wed, Nov 28, 2012 at 7:02 PM, liu muye <lmy19901031@gmail.com> wrote:
>>> Even though all my nodes are running batman-adv. I still do the same
>>> thing to obtain the MAC address of bat0.
>>> Is that right?
>>>
>>> Thanks
>>>
>>> On Wed, Nov 28, 2012 at 6:48 PM, liu muye <lmy19901031@gmail.com> wrote:
>>>> So, if I understood correctly. The best way to do is to run command
>>>> "ifconfig bat0" on both sides and fill in the HWAddr info accordingly.
>>>>
>>>> Thanks
>>>>
>>>> On Wed, Nov 28, 2012 at 6:29 PM, liu muye <lmy19901031@gmail.com> wrote:
>>>>> OK, Thanks for the clarification. Just wonder if there is any way to
>>>>> get the MAC address of bat0 on other end.
>>>>>
>>>>> For example: I got node A and node C. I want to send data packet from
>>>>> node A to node C. The MAC address of bat0 in nodeA is the source. Just
>>>>> wandering if there is a way to get the MAC address of bat0 in node C
>>>>> without physically show up in front of node C and run these commands.
>>>>>
>>>>> Thank you so much
>>>>>
>>>>>
>>>>>
>>>>> On Wed, Nov 28, 2012 at 6:09 PM, liu muye <lmy19901031@gmail.com> wrote:
>>>>>> Besides, when do batctl ping. I am using the MAC address of ah0. I can
>>>>>> ping other node.
>>>>>> If the MAC address is wrong, I think I cannot even ping another node,
>>>>>> or traceroute to another node.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> On Wed, Nov 28, 2012 at 6:02 PM, liu muye <lmy19901031@gmail.com> wrote:
>>>>>>> One follow up question:
>>>>>>>
>>>>>>> When I do batctl o. It shows the MAC address of my network interface.
>>>>>>> In my case, is ah0.
>>>>>>> Not sure what to do in order to show the MAC address of the bat0.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Muye Liu
>>>>>>>
>>>>>>> On Tue, Nov 27, 2012 at 11:15 PM, liu muye <lmy19901031@gmail.com> wrote:
>>>>>>>> Hello:
>>>>>>>>
>>>>>>>> This is Muye again. I have encountered another problem recently when I
>>>>>>>> am using B.A.T.M.A.N to do the socket programming.
>>>>>>>>
>>>>>>>> Currently, I have three nodes. Namely, node A, node B, and node C. The
>>>>>>>> testing environment is a hall way in our department.
>>>>>>>>
>>>>>>>> I put node A in one end of the hall way, node C in another end of the
>>>>>>>> hall way. Node B is in the middle of the hall way.
>>>>>>>>
>>>>>>>> I can ping node C from node A and vice versa. In node A, I can
>>>>>>>> traceroute to node C. The traceroute shows it needs to go through node
>>>>>>>> B.
>>>>>>>>
>>>>>>>> However, when I send packet from node A to node C. Node C does not
>>>>>>>> receive anything. But if I send packet from node A to node B, node B
>>>>>>>> can receive that packet.
>>>>>>>> Not sure what happened.  The link shown below is the program I used to
>>>>>>>> send packet. Both source and destination are MAC address.
>>>>>>>>
>>>>>>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/20111206/52f060cb/attachment.c
>>>>>>>>
>>>>>>>> I greatly appreciate any suggestion, comment, and help.
>>>>>>>>
>>>>>>>> Thanks
