Return-Path: <r.krishnathiepan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <545CF861.2000304@meshcoding.com>
References: <CAEbDFcSO2jVkSKwS5KirqNLmfT69X5jDA0qW_nP3KaZRkFnNuw@mail.gmail.com>
 <545CF861.2000304@meshcoding.com>
Date: Sat, 8 Nov 2014 09:00:53 +0530
Message-ID: <CAEbDFcQkyHHSMWcF2tMN_TfRTV3Or4GMScS0Mp=OovOKfZ4Rbg@mail.gmail.com>
From: Krishnathiepan Rasanayagam <r.krishnathiepan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Queues in batman-adv
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

Hi Antonio,

Im aware that batman-adv doesn't care about tcp or udp and it doesn't
have any queues either. what i want is how it handles the out going
packets more specifically how it places the Frames on net. what file
does this and what headers supports this?

cheers,
krishna

On Fri, Nov 7, 2014 at 10:20 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
> On 07/11/14 05:07, Krishnathiepan Rasanayagam wrote:
>> hi All,
>>
>> Can any one explain me how the tcp buffers were handled in batman-adv.
>> or which files it handled ?
>> We are trying to modify the way batman-adv handles the data buffer.
>
>
> Hi Krishnathiepan,
>
> batman-adv does not have any buffer for outgoing packets.
>
> Moreover batman-adv has no clue about the upper layer protocols,
> therefore it has no knowledge about TCP or UDP.
>
>
> Cheers,
>
>
> --
> Antonio Quartulli
>



-- 
Best regards,
Krishna.
