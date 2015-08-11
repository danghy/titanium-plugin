package ti.mobileapptracker;

import org.appcelerator.kroll.common.Log;
import com.mobileapptracker.MATResponse;
import org.json.JSONObject;

public class MyMATResponse implements MATResponse {
    @Override
    public void enqueuedActionWithRefId(String refId) {
        // call has been queued, will be sent later
    }

    @Override
    public void didSucceedWithData(JSONObject data) {
        Log.d("MAT.success", data.toString());
    }

    @Override
    public void didFailWithError(JSONObject error) {
        Log.d("MAT.failure", error.toString());
    }
}